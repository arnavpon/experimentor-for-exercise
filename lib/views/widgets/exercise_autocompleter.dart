import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:experimentor_for_exercise/models/database.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:experimentor_for_exercise/shared/form_input_validator.dart';

class ExerciseAutocompleter extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final MyDatabase _database;
  final _updateName;
  final String _defaultText; // so we can pass in a default

  ExerciseAutocompleter(this._database, this._updateName,
      {Key? key, String defaultText = ""})
      : this._defaultText = defaultText,
        super(key: key);

  Future<Iterable<WeightliftingExercise>> _fetchExercises(String input) async {
    if (input.trim().isEmpty) {
      return <
          WeightliftingExercise>[]; // wait until user starts typing before suggesting
    }
    var _exerciseList = await this._database.allExercises; // *** use provider
    return _exerciseList.where((WeightliftingExercise exercise) {
      return exercise.name.toLowerCase().contains(input.toLowerCase());
    });
  }

  static String _displayExerciseForOption(String exercise) =>
      exercise.toUpperCase(); // value that is displayed in autocomplete list

  @override
  Widget build(BuildContext context) {
    this._controller.text =
        _defaultText; // set exercise name if it is passed in
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._controller,
          decoration: InputDecoration(hintText: "exercise name")),
      suggestionsCallback: (String input) async {
        return await _fetchExercises(input);
      },
      itemBuilder: (context, suggestion) {
        String exercise = (suggestion == null)
            ? ""
            : (suggestion as WeightliftingExercise).name; // get exercise name
        return ListTile(title: Text(_displayExerciseForOption(exercise)));
      },
      onSuggestionSelected: (suggestion) {
        log("selected option: $suggestion");
        this._controller.text = (suggestion == null)
            ? ""
            : (suggestion as WeightliftingExercise)
                .name; // set the text value w/ the suggestion
      },
      validator: StringFormInputValidator().validateInput,
      onSaved: (String? value) {
        this._updateName(value!);
      },
    );
  }
}
