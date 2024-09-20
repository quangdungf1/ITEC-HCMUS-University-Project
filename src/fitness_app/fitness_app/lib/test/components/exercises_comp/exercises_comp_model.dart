import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'exercises_comp_widget.dart' show ExercisesCompWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExercisesCompModel extends FlutterFlowModel<ExercisesCompWidget> {
  ///  Local state fields for this component.

  int? total = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for CheckboxListTile widget.
  Map<ExercisesRecord, bool> checkboxListTileValueMap = {};
  List<ExercisesRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
