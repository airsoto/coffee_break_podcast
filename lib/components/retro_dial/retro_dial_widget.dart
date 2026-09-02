import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'retro_dial_model.dart';
export 'retro_dial_model.dart';

class RetroDialWidget extends StatefulWidget {
  const RetroDialWidget({
    super.key,
    double? angle,
  }) : this.angle = angle ?? 45.0;

  final double angle;

  @override
  State<RetroDialWidget> createState() => _RetroDialWidgetState();
}

class _RetroDialWidgetState extends State<RetroDialWidget> {
  late RetroDialModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RetroDialModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Color(0xFF5C4033),
        borderRadius: BorderRadius.circular(9999.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Color(0xFF3E2B22),
          width: 3.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 48.0,
        height: 48.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primary,
          borderRadius: BorderRadius.circular(9999.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: FlutterFlowTheme.of(context).tertiary,
            width: 2.0,
          ),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Align(
          alignment: AlignmentDirectional(0.0, -0.8),
          child: Transform.rotate(
            angle: valueOrDefault<double>(
                  widget!.angle,
                  45.0,
                ) *
                (math.pi / 180),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: 4.0,
              height: 16.0,
              decoration: BoxDecoration(
                color: Color(0xFF5C4033),
                borderRadius: BorderRadius.circular(2.0),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
