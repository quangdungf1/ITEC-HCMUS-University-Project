import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/test/components/header/header_widget.dart';
import '/test/components/how_to_cal_calories_burn/how_to_cal_calories_burn_widget.dart';
import '/test/components/how_to_cal_calories_needed/how_to_cal_calories_needed_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  List<String> caloriesName = [];
  void addToCaloriesName(String item) => caloriesName.add(item);
  void removeFromCaloriesName(String item) => caloriesName.remove(item);
  void removeAtIndexFromCaloriesName(int index) => caloriesName.removeAt(index);
  void insertAtIndexInCaloriesName(int index, String item) =>
      caloriesName.insert(index, item);
  void updateCaloriesNameAtIndex(int index, Function(String) updateFn) =>
      caloriesName[index] = updateFn(caloriesName[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Header component.
  late HeaderModel headerModel;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    headerModel.dispose();
  }
}
