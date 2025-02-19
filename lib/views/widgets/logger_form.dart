import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../models/database.dart';
import '../../shared/form_input_validator.dart';

class LoggerForm extends StatefulWidget {
  final AppDatabase _db;
  const LoggerForm(this._db, {Key? key}) : super(key: key);

  @override
  _LoggerFormState createState() => _LoggerFormState();
}

class _LoggerFormState extends State<LoggerForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _movement = ""; // name of current exercise
  String _equipmentType = ""; // type of equipment being used
  int _repCount = 0;
  double _weight = 0;

  final _movementController = TextEditingController();
  final _equipmentTypeController = TextEditingController();
  final _weightFieldController = TextEditingController();

  Future _reportCompletedSet(AppDatabase db) async {
    if (_formKey.currentState!.validate()) {
      // validate form
      print(_formKey.currentState);
      _formKey.currentState!.save(); // save entries
      print(
          "Exercise: $_movement | Equipment: $_equipmentType | Weight: $_weight | Reps; $_repCount");

      // write to db & udate UI
      var movementMatches = await (widget._db.select(widget._db.movements)
            ..where((e) => e.name.equals(_movement)))
          .get();
      var equipmentTypeMatches =
          await (widget._db.select(widget._db.equipmentTypes)
                ..where((e) => e.name.equals(_equipmentType)))
              .get();
      if (movementMatches.length == 0) {
        // only add exercise -> db if it doesn't already exist
        var _ = await db.into(db.movements).insert(
            MovementsCompanion.insert(name: _movement.toLowerCase().trim()));
      } else if (movementMatches.length > 1) {
        print("\nError: more than 1 movement with same name found");
      }
      if (equipmentTypeMatches.length == 0) {
        // only add exercise -> db if it doesn't already exist
        var _ = await db.into(db.equipmentTypes).insert(
            EquipmentTypesCompanion.insert(
                name: _equipmentType.toLowerCase().trim()));
      } else if (equipmentTypeMatches.length > 1) {
        print("\nError: more than 1 movement with same name found");
      }

      await db.into(db.weightliftingSet).insert(
          WeightliftingSetCompanion.insert(
              movement: _movement.toLowerCase().trim(),
              equipmentType: _equipmentType.toLowerCase().trim(),
              nOfReps: _repCount,
              weight: _weight)); // add set -> db
      var allMovements = await db.select(db.movements).get(); // ***
      print(allMovements.toString()); // ***
      var allEquipmentTypes = await db.select(db.equipmentTypes).get(); // ***
      print(allEquipmentTypes.toString()); // ***
      var entries = await db.select(db.weightliftingSet).get(); // ***
      print(entries.toString()); // ***

      setState(() {
        _formKey.currentState!.reset(); // reset UI
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Log your workout"),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          TypeAheadField<Movement>(
                            controller: _movementController,
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration:
                                    const InputDecoration(hintText: "movement"),
                                validator:
                                    StringFormInputValidator().validateInput,
                                onSaved: (String? value) {
                                  _movement = value!;
                                },
                              );
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.name),
                              );
                            },
                            onSelected: (value) {
                              _movementController.text = value.name;
                            },
                            suggestionsCallback: (input) async {
                              if (input.isEmpty) {
                                return null;
                              }
                              var results = await widget._db
                                  .select(widget._db.movements)
                                  .get();
                              return results
                                  .where((e) => e.name
                                      .toLowerCase()
                                      .contains(input.toLowerCase()))
                                  .toList();
                            },
                            hideOnEmpty: true,
                          ),
                          TypeAheadField<EquipmentType>(
                            controller: _equipmentTypeController,
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                    hintText: "equipment type (e.g. dumbbell)"),
                                validator:
                                    StringFormInputValidator().validateInput,
                                onSaved: (String? value) {
                                  _equipmentType = value!;
                                },
                              );
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.name),
                              );
                            },
                            onSelected: (value) {
                              _equipmentTypeController.text = value.name;
                            },
                            suggestionsCallback: (input) async {
                              if (input.isEmpty) {
                                return null;
                              }
                              var results = await widget._db
                                  .select(widget._db.equipmentTypes)
                                  .get();
                              return results
                                  .where((e) => e.name
                                      .toLowerCase()
                                      .contains(input.toLowerCase()))
                                  .toList();
                            },
                            hideOnEmpty: true,
                          ),
                          TextFormField(
                            controller: _weightFieldController,
                            decoration: const InputDecoration(
                                hintText: "weight (lbs.)"),
                            validator:
                                NumericalFormInputValidator().validateInput,
                            onSaved: (String? value) {
                              _weight = double.parse(value!);
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(hintText: "# of reps"),
                            validator:
                                IntegerFormInputValidator().validateInput,
                            onSaved: (String? value) {
                              _repCount = int.parse(value!);
                            },
                          ),
                          ElevatedButton(
                            onPressed: () => _reportCompletedSet(widget._db),
                            child: Row(children: [
                              const Icon(Icons.save),
                              const Text("  Save"),
                            ]),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            Container(),
          ]),
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.fitness_center)),
              Tab(
                icon: Icon(Icons.heart_broken),
              ),
            ]),
          ),
        ));
  }
}
