import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/test/components/rate_excompo/rate_excompo_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'exercises_widget.dart' show ExercisesWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class ExercisesModel extends FlutterFlowModel<ExercisesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for searchEx widget.
  final searchExKey = GlobalKey();
  FocusNode? searchExFocusNode;
  TextEditingController? searchExTextController;
  String? searchExSelectedOption;
  String? Function(BuildContext, String?)? searchExTextControllerValidator;
  List<ExercisesRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    searchExFocusNode?.dispose();
  }
}
