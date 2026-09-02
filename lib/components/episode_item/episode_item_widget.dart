import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'episode_item_model.dart';
export 'episode_item_model.dart';

class EpisodeItemWidget extends StatefulWidget {
  const EpisodeItemWidget({
    super.key,
    String? duration,
    String? title,
    bool? isDownloaded,
  })  : this.duration = duration ?? '45:12',
        this.title = title ?? 'The Analog Revolution',
        this.isDownloaded = isDownloaded ?? true;

  final String duration;
  final String title;
  final bool isDownloaded;

  @override
  State<EpisodeItemWidget> createState() => _EpisodeItemWidgetState();
}

class _EpisodeItemWidgetState extends State<EpisodeItemWidget> {
  late EpisodeItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EpisodeItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).onPrimaryContainer,
            borderRadius: BorderRadius.circular(8.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Color(0xFF5C4033),
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondary,
                      borderRadius: BorderRadius.circular(9999.0),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0xFF5C4033),
                        width: 2.0,
                      ),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      child: Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        children: [
                          if (valueOrDefault<bool>(
                            valueOrDefault<bool>(
                              widget!.isDownloaded,
                              true,
                            )
                                ? true
                                : false,
                            true,
                          ))
                            Icon(
                              Icons.download_done_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .onPrimaryContainer,
                              size: 24.0,
                            ),
                          if (valueOrDefault<bool>(
                            valueOrDefault<bool>(
                              widget!.isDownloaded,
                              true,
                            )
                                ? false
                                : true,
                            false,
                          ))
                            Icon(
                              Icons.play_arrow_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .onPrimaryContainer,
                              size: 24.0,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            widget!.title,
                            'The Analog Revolution',
                          ),
                          maxLines: 1,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF5C4033),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    lineHeight: 1.55,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                widget!.duration,
                                '45:12',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                    lineHeight: 1.3,
                                  ),
                            ),
                            Container(
                              width: 4.0,
                              height: 4.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF5C4033),
                                borderRadius: BorderRadius.circular(9999.0),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            Text(
                              'Episode 12',
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
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
                          ].divide(SizedBox(width: 8.0)),
                        ),
                      ].divide(SizedBox(height: 4.0)),
                    ),
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    child: Stack(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      children: [
                        if (valueOrDefault<bool>(
                          valueOrDefault<bool>(
                            widget!.isDownloaded,
                            true,
                          )
                              ? true
                              : false,
                          true,
                        ))
                          Icon(
                            Icons.delete_outline_rounded,
                            color: FlutterFlowTheme.of(context).tertiary,
                            size: 20.0,
                          ),
                        if (valueOrDefault<bool>(
                          valueOrDefault<bool>(
                            widget!.isDownloaded,
                            true,
                          )
                              ? false
                              : true,
                          false,
                        ))
                          Icon(
                            Icons.add_circle_outline_rounded,
                            color: FlutterFlowTheme.of(context).tertiary,
                            size: 20.0,
                          ),
                      ],
                    ),
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
