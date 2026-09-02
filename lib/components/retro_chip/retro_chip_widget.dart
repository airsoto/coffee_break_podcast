import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'retro_chip_model.dart';
export 'retro_chip_model.dart';

class RetroChipWidget extends StatefulWidget {
  const RetroChipWidget({
    super.key,
    Color? bg,
    Color? border,
    String? label,
    Color? textColor,
  })  : this.bg = bg ?? const Color(0x00000000),
        this.border = border ?? const Color(0xFFB07D1E),
        this.label = label ?? 'Music',
        this.textColor = textColor ?? const Color(0xFF5C4033);

  final Color bg;
  final Color border;
  final String label;
  final Color textColor;

  @override
  State<RetroChipWidget> createState() => _RetroChipWidgetState();
}

class _RetroChipWidgetState extends State<RetroChipWidget> {
  late RetroChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RetroChipModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              widget!.bg,
              FlutterFlowTheme.of(context).primary,
            ),
            borderRadius: BorderRadius.circular(9999.0),
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 8.0),
            child: Container(
              child: Text(
                valueOrDefault<String>(
                  widget!.label,
                  'Music',
                ),
                style: FlutterFlowTheme.of(context).labelLarge.override(
                      font: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      ),
                      color: valueOrDefault<Color>(
                        widget!.textColor,
                        Color(0xFF5C4033),
                      ),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
