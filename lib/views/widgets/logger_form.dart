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

class _LoggerFormState extends State<LoggerForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TabController _tabController;

  // Weightlifting form variables
  String _movement = "";
  String _equipmentType = "";
  int _repCount = 0;
  double _weight = 0;

  // Cardio form variables
  String _cardioMovement = "";
  String _cardioEquipmentType = "";
  double _distance = 0.0; // in miles/km
  double _duration = 0.0; // in minutes

  // Controllers
  final _movementController = TextEditingController();
  final _equipmentTypeController = TextEditingController();
  final _weightFieldController = TextEditingController();
  final _repsFieldController = TextEditingController();
  final _cardioMovementController = TextEditingController();
  final _cardioEquipmentTypeController = TextEditingController();
  final _distanceController = TextEditingController();
  final _durationController = TextEditingController();
  final _powerOutputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _movementController.dispose();
    _equipmentTypeController.dispose();
    _weightFieldController.dispose();
    _repsFieldController.dispose();
    _cardioMovementController.dispose();
    _cardioEquipmentTypeController.dispose();
    _distanceController.dispose();
    _durationController.dispose();
    _powerOutputController.dispose();
    super.dispose();
  }

  // Add this method to handle cardio set submission
  Future _reportCompletedCardioSet(AppDatabase db) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(
          "Cardio Exercise: $_cardioMovement | Equipment: $_cardioEquipmentType | Distance: $_distance | Duration: $_duration");

      // Get or create movement record
      var movementMatches = await (widget._db.select(widget._db.movements)
            ..where((e) => e.name.equals(_cardioMovement)))
          .get();
      var equipmentTypeMatches =
          await (widget._db.select(widget._db.equipmentTypes)
                ..where((e) => e.name.equals(_cardioEquipmentType)))
              .get();

      if (movementMatches.isEmpty) {
        // Create new movement
        var movementEntry = MovementsCompanion.insert(name: _cardioMovement);
        await widget._db.into(widget._db.movements).insert(movementEntry);
      }

      if (equipmentTypeMatches.isEmpty) {
        // Create new equipment type
        var equipmentEntry =
            EquipmentTypesCompanion.insert(name: _cardioEquipmentType);
        await widget._db.into(widget._db.equipmentTypes).insert(equipmentEntry);
      }

      // Insert cardio set
      await widget._db
          .into(widget._db.cardioSet)
          .insert(CardioSetCompanion.insert(
            movement: _cardioMovement,
            equipmentType: _cardioEquipmentType,
            distance: _distance,
            duration: _duration,
          ));

      // Reset form
      setState(() {
        _cardioMovementController.clear();
        _cardioEquipmentTypeController.clear();
        _distanceController.clear();
        _durationController.clear();
        _powerOutputController.clear();
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cardio set added successfully!')),
      );
    }
  }

  Future _reportCompletedWeightliftingSet(AppDatabase db) async {
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
        _weightFieldController.clear();
        _repsFieldController.clear();
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('W/l set added successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.fitness_center), text: 'Strength'),
            Tab(icon: Icon(Icons.heart_broken), text: 'Cardio'),
          ],
          labelColor: Theme.of(context).primaryColor,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Strength Training Form (your existing form)
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Log your workout"),
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: <Widget>[
                              TypeAheadField<Movement>(
                                controller: _movementController,
                                builder: (context, controller, focusNode) {
                                  return TextFormField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    decoration: const InputDecoration(
                                        hintText: "movement"),
                                    validator: StringFormInputValidator()
                                        .validateInput,
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
                                        hintText:
                                            "equipment type (e.g. dumbbell)"),
                                    validator: StringFormInputValidator()
                                        .validateInput,
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
                                controller: _repsFieldController,
                                decoration: const InputDecoration(
                                    hintText: "# of reps"),
                                validator:
                                    IntegerFormInputValidator().validateInput,
                                onSaved: (String? value) {
                                  _repCount = int.parse(value!);
                                },
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    _reportCompletedWeightliftingSet(
                                        widget._db),
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
              ),

              // Cardio Form
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text("Log your workout"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TypeAheadField<Movement>(
                          controller: _cardioMovementController,
                          builder: (context, controller, focusNode) {
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: const InputDecoration(
                                  hintText: "movement (e.g. running)"),
                              validator:
                                  StringFormInputValidator().validateInput,
                              onSaved: (String? value) {
                                _cardioMovement = value!;
                              },
                            );
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.name),
                            );
                          },
                          onSelected: (value) {
                            _cardioMovementController.text = value.name;
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TypeAheadField<EquipmentType>(
                          controller: _cardioEquipmentTypeController,
                          builder: (context, controller, focusNode) {
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: const InputDecoration(
                                  hintText: "equipment type (e.g. treadmill)"),
                              validator:
                                  StringFormInputValidator().validateInput,
                              onSaved: (String? value) {
                                _cardioEquipmentType = value!;
                              },
                            );
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.name),
                            );
                          },
                          onSelected: (value) {
                            _cardioEquipmentTypeController.text = value.name;
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _distanceController,
                          decoration: const InputDecoration(
                            labelText: 'Distance (miles)',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator:
                              NumericalFormInputValidator().validateInput,
                          onSaved: (value) {
                            _distance = double.parse(value ?? "0");
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _durationController,
                          decoration: const InputDecoration(
                            labelText: 'Duration (seconds)',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator:
                              NumericalFormInputValidator().validateInput,
                          onSaved: (value) {
                            _duration = double.parse(value ?? "0");
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _powerOutputController,
                          decoration: const InputDecoration(
                            labelText: 'Power Output [W]',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator:
                              NumericalFormInputValidator().validateInput,
                          onSaved: (value) {
                            _duration = double.parse(value ?? "0");
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () =>
                              _reportCompletedCardioSet(widget._db),
                          child: const Text('Save Cardio Set'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
