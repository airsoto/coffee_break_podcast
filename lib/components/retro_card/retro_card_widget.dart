import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'retro_card_model.dart';
export 'retro_card_model.dart';

class RetroCardWidget extends StatefulWidget {
  const RetroCardWidget({
    super.key,
    Color? bg,
    Color? borderColor,
    Color? shadowColor,
    this.child,
  })  : this.bg = bg ?? const Color(0x00000000),
        this.borderColor = borderColor ?? const Color(0xFF5C4033),
        this.shadowColor = shadowColor ?? const Color(0x335C4033);

  final Color bg;
  final Color borderColor;
  final Color shadowColor;
  final Widget Function()? child;

  @override
  State<RetroCardWidget> createState() => _RetroCardWidgetState();
}

class _RetroCardWidgetState extends State<RetroCardWidget> {
  late RetroCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RetroCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              widget!.bg,
              FlutterFlowTheme.of(context).secondaryBackground,
            ),
            borderRadius: BorderRadius.circular(16.0),
            shape: BoxShape.rectangle,
          ),
          child: Container(
            child: Builder(builder: (_) {
              return widget.child != null ? widget.child!() : SizedBox.shrink();
            }),
          ),
        ),
      ),
    );
  }
}
