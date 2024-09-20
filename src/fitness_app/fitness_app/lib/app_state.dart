import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  WorkoutStruct _workout = WorkoutStruct();
  WorkoutStruct get workout => _workout;
  set workout(WorkoutStruct value) {
    _workout = value;
  }

  void updateWorkoutStruct(Function(WorkoutStruct) updateFn) {
    updateFn(_workout);
  }

  bool _searchExActive = false;
  bool get searchExActive => _searchExActive;
  set searchExActive(bool value) {
    _searchExActive = value;
  }

  bool _hasWorkOut = false;
  bool get hasWorkOut => _hasWorkOut;
  set hasWorkOut(bool value) {
    _hasWorkOut = value;
  }
}
