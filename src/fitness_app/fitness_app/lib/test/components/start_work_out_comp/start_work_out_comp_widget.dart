import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/test/components/exercises_comp/exercises_comp_widget.dart';
import '/test/components/input_reps/input_reps_widget.dart';
import '/test/components/input_weight/input_weight_widget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'start_work_out_comp_model.dart';
export 'start_work_out_comp_model.dart';

class StartWorkOutCompWidget extends StatefulWidget {
  const StartWorkOutCompWidget({super.key});

  @override
  State<StartWorkOutCompWidget> createState() => _StartWorkOutCompWidgetState();
}

class _StartWorkOutCompWidgetState extends State<StartWorkOutCompWidget> {
  late StartWorkOutCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartWorkOutCompModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onStartTimer();
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryText,
      ),
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          onFieldSubmitted: (_) async {
                            FFAppState().updateWorkoutStruct(
                              (e) => e..name = _model.textController.text,
                            );
                            setState(() {});
                          },
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Enter Workout name...',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  letterSpacing: 0.0,
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
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).alternate,
                                letterSpacing: 0.0,
                              ),
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowTimer(
                      initialTime: _model.timerInitialTimeMs,
                      getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                        value,
                        hours: false,
                        milliSecond: false,
                      ),
                      controller: _model.timerController,
                      updateStateInterval: Duration(milliseconds: 1000),
                      onChanged: (value, displayTime, shouldUpdate) {
                        _model.timerMilliseconds = value;
                        _model.timerValue = displayTime;
                        if (shouldUpdate) setState(() {});
                      },
                      textAlign: TextAlign.start,
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context).alternate,
                                letterSpacing: 0.0,
                              ),
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  final exercise = FFAppState().workout.exercises.toList();

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: exercise.length,
                    itemBuilder: (context, exerciseIndex) {
                      final exerciseItem = exercise[exerciseIndex];
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StreamBuilder<ExercisesRecord>(
                            stream: ExercisesRecord.getDocument(
                                exerciseItem.exerciseRefs!),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final textExercisesRecord = snapshot.data!;

                              return Text(
                                textExercisesRecord.name,
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFFF8F8F8),
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                    ),
                              );
                            },
                          ),
                          Builder(
                            builder: (context) {
                              final currentSets = exerciseItem.sets.toList();

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: currentSets.length,
                                itemBuilder: (context, currentSetsIndex) {
                                  final currentSetsItem =
                                      currentSets[currentSetsIndex];
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: wrapWithModel(
                                          model:
                                              _model.inputWeightModels.getModel(
                                            '${currentSetsItem.number.toString()}${exerciseItem.exerciseRefs?.id}',
                                            currentSetsIndex,
                                          ),
                                          updateCallback: () => setState(() {}),
                                          updateOnChange: true,
                                          child: InputWeightWidget(
                                            key: Key(
                                              'Keyc6w_${'${currentSetsItem.number.toString()}${exerciseItem.exerciseRefs?.id}'}',
                                            ),
                                            parameter1: currentSetsItem.weight,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: wrapWithModel(
                                          model:
                                              _model.inputRepsModels.getModel(
                                            '${currentSetsItem.number.toString()}${exerciseItem.exerciseRefs?.id}',
                                            currentSetsIndex,
                                          ),
                                          updateCallback: () => setState(() {}),
                                          updateOnChange: true,
                                          child: InputRepsWidget(
                                            key: Key(
                                              'Keydce_${'${currentSetsItem.number.toString()}${exerciseItem.exerciseRefs?.id}'}',
                                            ),
                                            parameter1: currentSetsItem.reps,
                                          ),
                                        ),
                                      ),
                                      if (currentSetsIndex ==
                                          (exerciseItem.sets.length - 1))
                                        FlutterFlowIconButton(
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          borderRadius: 20.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          fillColor: Color(0xFFEEE6E9),
                                          icon: Icon(
                                            Icons.delete,
                                            color: Color(0xFFF80004),
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            FFAppState().updateWorkoutStruct(
                                              (e) => e
                                                ..updateExercises(
                                                  (e) => e[exerciseIndex]
                                                    ..updateSets(
                                                      (e) => e.removeAt(
                                                          currentSetsIndex),
                                                    ),
                                                ),
                                            );
                                            setState(() {});
                                          },
                                        ),
                                      FlutterFlowIconButton(
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        borderRadius: 20.0,
                                        borderWidth: 1.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .alternate,
                                        icon: Icon(
                                          Icons.save_alt,
                                          color: Color(0xFF0FF41E),
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          FFAppState().updateWorkoutStruct(
                                            (e) => e
                                              ..updateExercises(
                                                (e) => e[exerciseIndex]
                                                  ..updateSets(
                                                    (e) => e[currentSetsIndex]
                                                      ..weight =
                                                          valueOrDefault<int>(
                                                        int.tryParse(_model
                                                                .inputWeightModels
                                                                .getValueForKey(
                                                              '${currentSetsItem.number.toString()}${exerciseItem.exerciseRefs?.id}',
                                                              (m) => m
                                                                  .textController
                                                                  .text,
                                                            ) ??
                                                            ''),
                                                        100,
                                                      )
                                                      ..reps =
                                                          valueOrDefault<int>(
                                                        int.tryParse(_model
                                                                .inputRepsModels
                                                                .getValueForKey(
                                                              '${currentSetsItem.number.toString()}${exerciseItem.exerciseRefs?.id}',
                                                              (m) => m
                                                                  .textController
                                                                  .text,
                                                            ) ??
                                                            ''),
                                                        100,
                                                      ),
                                                  ),
                                              ),
                                          );
                                          setState(() {});
                                          _model.calories =
                                              _model.calories! + 100;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                FFAppState().updateWorkoutStruct(
                                  (e) => e
                                    ..updateExercises(
                                      (e) => e[exerciseIndex]
                                        ..updateSets(
                                          (e) => e.add(SetStruct(
                                            weight: 0,
                                            reps: 0,
                                            number: 1,
                                          )),
                                        ),
                                    ),
                                );
                                setState(() {});
                              },
                              text: 'NEW SET',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF2D6A4F),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: ExercisesCompWidget(),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        text: 'Add Exercise',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFF2D6A4F),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      await WorksoutRecord.createDoc(currentUserReference!)
                          .set({
                        ...createWorksoutRecordData(
                          name: _model.textController.text,
                          timestamp: getCurrentTimestamp,
                          duration: _model.timerMilliseconds.toDouble(),
                          calories: valueOrDefault<double>(
                            double.parse((_model.timerMilliseconds / 1000 / 60)
                                .toStringAsFixed(2)),
                            5.0,
                          ),
                        ),
                        ...mapToFirestore(
                          {
                            'exercises': getExerciseListFirestoreData(
                              FFAppState().workout.exercises,
                            ),
                          },
                        ),
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'WORKOUT SAVED!',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                      FFAppState().workout = WorkoutStruct();
                      setState(() {});
                    },
                    text: 'SAVE',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFF0A9A5A),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                      FFAppState().workout = WorkoutStruct();
                      setState(() {});
                    },
                    text: 'CANCEL',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFF04030B),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
