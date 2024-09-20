import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'exercises_comp_model.dart';
export 'exercises_comp_model.dart';

class ExercisesCompWidget extends StatefulWidget {
  const ExercisesCompWidget({super.key});

  @override
  State<ExercisesCompWidget> createState() => _ExercisesCompWidgetState();
}

class _ExercisesCompWidgetState extends State<ExercisesCompWidget> {
  late ExercisesCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExercisesCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsets.all(14.0),
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryText,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: 'Confirm',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFF488F6A),
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
              FutureBuilder<List<ExercisesRecord>>(
                future: queryExercisesRecordOnce(
                  queryBuilder: (exercisesRecord) =>
                      exercisesRecord.orderBy('name'),
                ),
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
                  List<ExercisesRecord> listViewExercisesRecordList =
                      snapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewExercisesRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewExercisesRecord =
                          listViewExercisesRecordList[listViewIndex];
                      return Theme(
                        data: ThemeData(
                          checkboxTheme: CheckboxThemeData(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          unselectedWidgetColor:
                              FlutterFlowTheme.of(context).secondaryText,
                        ),
                        child: CheckboxListTile(
                          value: _model.checkboxListTileValueMap[
                                  listViewExercisesRecord] ??=
                              FFAppState()
                                  .workout
                                  .exercises
                                  .map((e) => e.exerciseRefs?.id)
                                  .withoutNulls
                                  .toList()
                                  .contains(
                                      listViewExercisesRecord.reference.id),
                          onChanged: (newValue) async {
                            setState(() => _model.checkboxListTileValueMap[
                                listViewExercisesRecord] = newValue!);
                            if (newValue!) {
                              _model.total = _model.total! + 1;
                              setState(() {});
                              FFAppState().updateWorkoutStruct(
                                (e) => e
                                  ..updateExercises(
                                    (e) => e.add(ExerciseStruct(
                                      exerciseRefs:
                                          listViewExercisesRecord.reference,
                                      sets: functions.createSets(),
                                    )),
                                  ),
                              );
                              setState(() {});
                            } else {
                              _model.total = _model.total! + -1;
                              setState(() {});
                              FFAppState().updateWorkoutStruct(
                                (e) => e
                                  ..updateExercises(
                                    (e) => e.remove(ExerciseStruct(
                                      exerciseRefs:
                                          listViewExercisesRecord.reference,
                                    )),
                                  ),
                              );
                              setState(() {});
                            }
                          },
                          title: Text(
                            listViewExercisesRecord.name,
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          subtitle: Text(
                            listViewExercisesRecord.bodyPart,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          activeColor: FlutterFlowTheme.of(context).primary,
                          checkColor: FlutterFlowTheme.of(context).info,
                          dense: false,
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
