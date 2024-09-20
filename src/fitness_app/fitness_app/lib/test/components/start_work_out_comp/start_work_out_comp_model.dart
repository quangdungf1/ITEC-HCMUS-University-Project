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
import 'start_work_out_comp_widget.dart' show StartWorkOutCompWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartWorkOutCompModel extends FlutterFlowModel<StartWorkOutCompWidget> {
  ///  Local state fields for this component.

  int? calories;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 0;
  int timerMilliseconds = 0;
  String timerValue = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countUp));

  // Models for inputWeight dynamic component.
  late FlutterFlowDynamicModels<InputWeightModel> inputWeightModels;
  // Models for inputReps dynamic component.
  late FlutterFlowDynamicModels<InputRepsModel> inputRepsModels;

  @override
  void initState(BuildContext context) {
    inputWeightModels = FlutterFlowDynamicModels(() => InputWeightModel());
    inputRepsModels = FlutterFlowDynamicModels(() => InputRepsModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    timerController.dispose();
    inputWeightModels.dispose();
    inputRepsModels.dispose();
  }
}
