import '/components/retro_card/retro_card_widget.dart';
import '/components/retro_card_child/retro_card_child_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'show_item_widget.dart' show ShowItemWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShowItemModel extends FlutterFlowModel<ShowItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for RetroCard.
  late RetroCardModel retroCardModel;

  @override
  void initState(BuildContext context) {
    retroCardModel = createModel(context, () => RetroCardModel());
  }

  @override
  void dispose() {
    retroCardModel.dispose();
  }
}
