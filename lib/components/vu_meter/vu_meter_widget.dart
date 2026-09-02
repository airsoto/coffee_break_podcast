import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'vu_meter_model.dart';
export 'vu_meter_model.dart';

class VuMeterWidget extends StatefulWidget {
  const VuMeterWidget({
    super.key,
    Color? color,
    String? label,
  })  : this.color = color ?? const Color(0x00000000),
        this.label = label ?? 'LEFT';

  final Color color;
  final String label;

  @override
  State<VuMeterWidget> createState() => _VuMeterWidgetState();
}

class _VuMeterWidgetState extends State<VuMeterWidget> {
  late VuMeterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VuMeterModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          valueOrDefault<String>(
            widget!.label,
            'LEFT',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: Color(0xFF5C4033),
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.3,
              ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            width: 40.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).onPrimaryContainer,
              borderRadius: BorderRadius.circular(4.0),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Color(0xFF5C4033),
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Container(
                child: Container(
                  height: 72.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            widget!.color,
                            FlutterFlowTheme.of(context).secondary,
                          ),
                          borderRadius: BorderRadius.circular(1.0),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            widget!.color,
                            FlutterFlowTheme.of(context).secondary,
                          ),
                          borderRadius: BorderRadius.circular(1.0),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            widget!.color,
                            FlutterFlowTheme.of(context).secondary,
                          ),
                          borderRadius: BorderRadius.circular(1.0),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            widget!.color,
                            FlutterFlowTheme.of(context).secondary,
                          ),
                          borderRadius: BorderRadius.circular(1.0),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Opacity(
                        opacity: 0.3,
                        child: Container(
                          width: 30.0,
                          height: 4.0,
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              widget!.color,
                              FlutterFlowTheme.of(context).secondary,
                            ),
                            borderRadius: BorderRadius.circular(1.0),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.1,
                        child: Container(
                          width: 30.0,
                          height: 4.0,
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              widget!.color,
                              FlutterFlowTheme.of(context).secondary,
                            ),
                            borderRadius: BorderRadius.circular(1.0),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 2.0)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
