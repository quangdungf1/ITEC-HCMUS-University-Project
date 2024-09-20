import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_model.dart';
export 'profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with TickerProviderStateMixin {
  late ProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());

    animationsMap.addAll({
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 400.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 60.0),
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
    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<UsersRecord> profileUsersRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final profileUsersRecord = profileUsersRecordList.isNotEmpty
            ? profileUsersRecordList.first
            : null;

        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
                color: Color(0xFF242323),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200.0,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                '',
                              ),
                            ),
                          ),
                          child: AuthUserStreamWidget(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                final selectedMedia =
                                    await selectMediaWithSourceBottomSheet(
                                  context: context,
                                  maxWidth: 400.00,
                                  maxHeight: 200.00,
                                  imageQuality: 100,
                                  allowPhoto: true,
                                  pickerFontFamily: 'Lexend Deca',
                                );
                                if (selectedMedia != null &&
                                    selectedMedia.every((m) =>
                                        validateFileFormat(
                                            m.storagePath, context))) {
                                  setState(() => _model.isDataUploading = true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];

                                  var downloadUrls = <String>[];
                                  try {
                                    selectedUploadedFiles = selectedMedia
                                        .map((m) => FFUploadedFile(
                                              name:
                                                  m.storagePath.split('/').last,
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
                                    _model.isDataUploading = false;
                                  }
                                  if (selectedUploadedFiles.length ==
                                          selectedMedia.length &&
                                      downloadUrls.length ==
                                          selectedMedia.length) {
                                    setState(() {
                                      _model.uploadedLocalFile =
                                          selectedUploadedFiles.first;
                                      _model.uploadedFileUrl =
                                          downloadUrls.first;
                                    });
                                  } else {
                                    setState(() {});
                                    return;
                                  }
                                }

                                await profileUsersRecord!.reference
                                    .update(createUsersRecordData(
                                  backgroundImage: _model.uploadedFileUrl,
                                ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  valueOrDefault<String>(
                                    valueOrDefault(
                                        currentUserDocument?.backgroundImage,
                                        ''),
                                    'data:image/jpeg;base64,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',
                                  ),
                                  width: 300.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 0.0, 16.0),
                            child: Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent2,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          Duration(milliseconds: 800),
                                      fadeOutDuration:
                                          Duration(milliseconds: 800),
                                      imageUrl: valueOrDefault<String>(
                                        currentUserPhoto,
                                        'data:image/png;base64,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',
                                      ),
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => Text(
                        currentUserDisplayName,
                        style:
                            FlutterFlowTheme.of(context).headlineLarge.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF6AC970),
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 0.0, 16.0),
                    child: Text(
                      currentUserEmail,
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 0.0, 0.0),
                    child: Text(
                      'Your Account',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Noto Sans JP',
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('editProfie');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3.0,
                              color: FlutterFlowTheme.of(context).primaryText,
                              offset: Offset(
                                0.0,
                                1.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Edit Profile',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFFF1F2F2),
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0.9, 0.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 0.0, 0.0),
                    child: Text(
                      'Support User',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Noto Sans JP',
                            color: Color(0xFFF4F4F4),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('reportIssues');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF080707),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3.0,
                              color: Color(0x33000000),
                              offset: Offset(
                                0.0,
                                1.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.help_outline_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Create ticket',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFFFDFDFD),
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0.9, 0.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          context.goNamedAuth('Login', context.mounted);
                        },
                        text: 'Log Out',
                        icon: Icon(
                          Icons.logout_sharp,
                          color: Color(0xFF111010),
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          width: 150.0,
                          height: 44.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFFE32828),
                          textStyle:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(38.0),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['buttonOnPageLoadAnimation']!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
