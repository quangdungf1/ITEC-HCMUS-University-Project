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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'report_issues_model.dart';
export 'report_issues_model.dart';

class ReportIssuesWidget extends StatefulWidget {
  const ReportIssuesWidget({super.key});

  @override
  State<ReportIssuesWidget> createState() => _ReportIssuesWidgetState();
}

class _ReportIssuesWidgetState extends State<ReportIssuesWidget>
    with TickerProviderStateMixin {
  late ReportIssuesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportIssuesModel());

    _model.titleIssueTextController ??= TextEditingController();
    _model.titleIssueFocusNode ??= FocusNode();

    _model.issueDescriptionTextController ??= TextEditingController();
    _model.issueDescriptionFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 110.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wrapWithModel(
                      model: _model.headerModel,
                      updateCallback: () => setState(() {}),
                      child: HeaderWidget(),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          controller: _model.titleIssueTextController,
                          focusNode: _model.titleIssueFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Issue...',
                            labelStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 12.0),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model.titleIssueTextControllerValidator
                              .asValidator(context),
                        ),
                        TextFormField(
                          controller: _model.issueDescriptionTextController,
                          focusNode: _model.issueDescriptionFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            hintText:
                                'Short Description of what is going on...',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 24.0, 16.0, 12.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFFE6EBEE),
                                    letterSpacing: 0.0,
                                  ),
                          maxLines: 16,
                          minLines: 6,
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model
                              .issueDescriptionTextControllerValidator
                              .asValidator(context),
                        ),
                      ]
                          .divide(SizedBox(height: 16.0))
                          .addToStart(SizedBox(height: 12.0)),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          valueOrDefault<String>(
                            _model.uploadedFileUrl1,
                            'data:image/jpeg;base64,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',
                          ),
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 500.0,
                        ),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryText,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                maxWidth: 150.00,
                                maxHeight: 200.00,
                                imageQuality: 100,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                setState(() => _model.isDataUploading1 = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                var downloadUrls = <String>[];
                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                          ))
                                      .toList();

                                  downloadUrls = (await Future.wait(
                                    selectedMedia.map(
                                      (m) async => await uploadData(
                                          m.storagePath, m.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  _model.isDataUploading1 = false;
                                }
                                if (selectedUploadedFiles.length ==
                                        selectedMedia.length &&
                                    downloadUrls.length ==
                                        selectedMedia.length) {
                                  setState(() {
                                    _model.uploadedLocalFile1 =
                                        selectedUploadedFiles.first;
                                    _model.uploadedFileUrl1 =
                                        downloadUrls.first;
                                  });
                                } else {
                                  setState(() {});
                                  return;
                                }
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      maxWidth: 150.00,
                                      maxHeight: 200.00,
                                      imageQuality: 100,
                                      allowPhoto: true,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading2 = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        _model.isDataUploading2 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile2 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl2 =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        setState(() {});
                                        return;
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.add_a_photo_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    size: 32.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Upload Screenshot',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 12.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await IssueRecord.createDoc(currentUserReference!)
                              .set(createIssueRecordData(
                            title: _model.titleIssueTextController.text,
                            description:
                                _model.issueDescriptionTextController.text,
                            image: _model.uploadedFileUrl1,
                          ));
                          context.safePop();
                        },
                        text: 'Submit',
                        icon: Icon(
                          Icons.receipt_long,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 54.0,
                          padding: EdgeInsets.all(0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFF31B478),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 4.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 12.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.safePop();
                        },
                        text: 'Cancel',
                        icon: Icon(
                          Icons.receipt_long,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 54.0,
                          padding: EdgeInsets.all(0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 4.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
