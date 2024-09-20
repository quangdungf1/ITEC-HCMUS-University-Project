import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/test/components/header/header_widget.dart';
import 'dart:math';
import 'report_issues_widget.dart' show ReportIssuesWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReportIssuesModel extends FlutterFlowModel<ReportIssuesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Header component.
  late HeaderModel headerModel;
  // State field(s) for titleIssue widget.
  FocusNode? titleIssueFocusNode;
  TextEditingController? titleIssueTextController;
  String? Function(BuildContext, String?)? titleIssueTextControllerValidator;
  // State field(s) for issueDescription widget.
  FocusNode? issueDescriptionFocusNode;
  TextEditingController? issueDescriptionTextController;
  String? Function(BuildContext, String?)?
      issueDescriptionTextControllerValidator;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    headerModel.dispose();
    titleIssueFocusNode?.dispose();
    titleIssueTextController?.dispose();

    issueDescriptionFocusNode?.dispose();
    issueDescriptionTextController?.dispose();
  }
}
