import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'category_card_model.dart';
export 'category_card_model.dart';

class CategoryCardWidget extends StatefulWidget {
  const CategoryCardWidget({
    super.key,
    Color? bg,
    Color? borderColor,
    this.icon,
    String? subtitle,
    Color? textColor,
    String? title,
  })  : this.bg = bg ?? const Color(0x00000000),
        this.borderColor = borderColor ?? const Color(0xFF8B3D02),
        this.subtitle = subtitle ?? '2.4k shows',
        this.textColor = textColor ?? const Color(0x00000000),
        this.title = title ?? 'True Crime';

  final Color bg;
  final Color borderColor;
  final Widget? icon;
  final String subtitle;
  final Color textColor;
  final String title;

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  late CategoryCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoryCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 120.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            widget!.bg,
            FlutterFlowTheme.of(context).tertiary,
          ),
          borderRadius: BorderRadius.circular(16.0),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Stack(
              alignment: AlignmentDirectional(-1.0, -1.0),
              children: [
                Opacity(
                  opacity: 0.1,
                  child: Align(
                    alignment: AlignmentDirectional(1.0, -1.0),
                    child: Transform.rotate(
                      angle: 15.0 * (math.pi / 180),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        child: widget!.icon!,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget!.title,
                          'True Crime',
                        ),
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              font: GoogleFonts.spaceGrotesk(
                                fontWeight: FontWeight.w800,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                              color: valueOrDefault<Color>(
                                widget!.textColor,
                                FlutterFlowTheme.of(context).onPrimaryContainer,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w800,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                              lineHeight: 1.45,
                            ),
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          valueOrDefault<String>(
                            widget!.subtitle,
                            '2.4k shows',
                          ),
                          style:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      widget!.textColor,
                                      FlutterFlowTheme.of(context)
                                          .onPrimaryContainer,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                    lineHeight: 1.3,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
