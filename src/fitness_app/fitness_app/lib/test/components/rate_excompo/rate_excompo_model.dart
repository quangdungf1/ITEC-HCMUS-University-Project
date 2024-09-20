import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'rate_excompo_widget.dart' show RateExcompoWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RateExcompoModel extends FlutterFlowModel<RateExcompoWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for ratePoints widget.
  FocusNode? ratePointsFocusNode;
  TextEditingController? ratePointsTextController;
  String? Function(BuildContext, String?)? ratePointsTextControllerValidator;
  // State field(s) for exComments widget.
  FocusNode? exCommentsFocusNode;
  TextEditingController? exCommentsTextController;
  String? Function(BuildContext, String?)? exCommentsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    ratePointsFocusNode?.dispose();
    ratePointsTextController?.dispose();

    exCommentsFocusNode?.dispose();
    exCommentsTextController?.dispose();
  }
}
