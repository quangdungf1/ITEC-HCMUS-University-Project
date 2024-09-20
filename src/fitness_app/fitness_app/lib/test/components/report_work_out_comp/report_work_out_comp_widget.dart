import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'report_work_out_comp_model.dart';
export 'report_work_out_comp_model.dart';

class ReportWorkOutCompWidget extends StatefulWidget {
  const ReportWorkOutCompWidget({
    super.key,
    this.parameter1,
  });

  final List<DateTime>? parameter1;

  @override
  State<ReportWorkOutCompWidget> createState() =>
      _ReportWorkOutCompWidgetState();
}

class _ReportWorkOutCompWidgetState extends State<ReportWorkOutCompWidget> {
  late ReportWorkOutCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportWorkOutCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'WorkOut Report',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).alternate,
                  fontSize: 30.0,
                  letterSpacing: 0.0,
                ),
          ),
          Container(
            width: double.infinity,
            height: 250.0,
            child: FlutterFlowBarChart(
              barData: [
                FFBarChartData(
                  yData: functions.getFrequency(widget!.parameter1!.toList()),
                  color: Color(0xFF2D6A4F),
                )
              ],
              xLabels: functions.getDays(),
              barWidth: 16.0,
              barBorderRadius: BorderRadius.circular(8.0),
              groupSpace: 8.0,
              alignment: BarChartAlignment.spaceAround,
              chartStylingInfo: ChartStylingInfo(
                backgroundColor: FlutterFlowTheme.of(context).primaryText,
                showGrid: true,
                borderColor: FlutterFlowTheme.of(context).secondaryText,
                borderWidth: 1.0,
              ),
              axisBounds: AxisBounds(),
              xAxisLabelInfo: AxisLabelInfo(
                showLabels: true,
                labelInterval: 10.0,
                reservedSize: 28.0,
              ),
              yAxisLabelInfo: AxisLabelInfo(
                showLabels: true,
                labelInterval: 10.0,
                reservedSize: 42.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
