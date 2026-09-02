import '/components/retro_card/retro_card_widget.dart';
import '/components/retro_card_child/retro_card_child_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'show_item_model.dart';
export 'show_item_model.dart';

class ShowItemWidget extends StatefulWidget {
  const ShowItemWidget({
    super.key,
    String? author,
    String? imgDesc,
    String? title,
  })  : this.author = author ?? 'Coffee Culture',
        this.imgDesc = imgDesc ??
            'https://dimg.dreamflow.cloud/v1/image/vintage%20coffee%20shop%20illustration',
        this.title = title ?? 'The Daily Grind';

  final String author;
  final String imgDesc;
  final String title;

  @override
  State<ShowItemWidget> createState() => _ShowItemWidgetState();
}

class _ShowItemWidgetState extends State<ShowItemWidget> {
  late ShowItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShowItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: wrapWithModel(
        model: _model.retroCardModel,
        updateCallback: () => safeSetState(() {}),
        child: RetroCardWidget(
          bg: FlutterFlowTheme.of(context).secondaryBackground,
          borderColor: Color(0xFF5C4033),
          shadowColor: Color(0x335C4033),
          child: () => RetroCardChildWidget(
            title: valueOrDefault<String>(
              widget!.title,
              'The Daily Grind',
            ),
            author: valueOrDefault<String>(
              widget!.author,
              'Coffee Culture',
            ),
          ),
        ),
      ),
    );
  }
}
