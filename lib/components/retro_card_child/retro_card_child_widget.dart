import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'retro_card_child_model.dart';
export 'retro_card_child_model.dart';

class RetroCardChildWidget extends StatefulWidget {
  const RetroCardChildWidget({
    super.key,
    String? imgDesc,
    String? title,
    String? author,
  })  : this.imgDesc = imgDesc ??
            'https://dimg.dreamflow.cloud/v1/image/vintage%20coffee%20shop%20illustration',
        this.title = title ?? 'The Daily Grind',
        this.author = author ?? 'Coffee Culture';

  final String imgDesc;
  final String title;
  final String author;

  @override
  State<RetroCardChildWidget> createState() => _RetroCardChildWidgetState();
}

class _RetroCardChildWidgetState extends State<RetroCardChildWidget> {
  late RetroCardChildModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RetroCardChildModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Color(0xFF5C4033),
                width: 2.0,
              ),
            ),
            child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 0),
              fadeOutDuration: Duration(milliseconds: 0),
              imageUrl: valueOrDefault<String>(
                widget!.imgDesc,
                'https://dimg.dreamflow.cloud/v1/image/vintage%20coffee%20shop%20illustration',
              ),
              fit: BoxFit.cover,
              alignment: Alignment(0.0, 0.0),
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
                  'The Daily Grind',
                ),
                maxLines: 1,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.w800,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w800,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      lineHeight: 1.45,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                valueOrDefault<String>(
                  widget!.author,
                  'Coffee Culture',
                ),
                style: FlutterFlowTheme.of(context).labelMedium.override(
                      font: GoogleFonts.outfit(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      lineHeight: 1.35,
                    ),
              ),
            ].divide(SizedBox(height: 4.0)),
          ),
        ),
        FlutterFlowIconButton(
          borderRadius: 8.0,
          buttonSize: 40.0,
          fillColor: Colors.transparent,
          icon: Icon(
            Icons.more_vert_rounded,
            color: Color(0xFF5C4033),
            size: 24.0,
          ),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
      ].divide(SizedBox(width: 16.0)),
    );
  }
}
