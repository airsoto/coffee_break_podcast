import '/components/button/button_widget.dart';
import '/components/episode_item2/episode_item2_widget.dart';
import '/components/retro_chip/retro_chip_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'show_details_widget.dart' show ShowDetailsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShowDetailsModel extends FlutterFlowModel<ShowDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel;
  // Model for RetroChip.
  late RetroChipModel retroChipModel1;
  // Model for RetroChip.
  late RetroChipModel retroChipModel2;
  // Model for RetroChip.
  late RetroChipModel retroChipModel3;
  // Model for EpisodeItem.
  late EpisodeItem2Model episodeItemModel1;
  // Model for EpisodeItem.
  late EpisodeItem2Model episodeItemModel2;
  // Model for EpisodeItem.
  late EpisodeItem2Model episodeItemModel3;
  // Model for EpisodeItem.
  late EpisodeItem2Model episodeItemModel4;
  // Model for EpisodeItem.
  late EpisodeItem2Model episodeItemModel5;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
    retroChipModel1 = createModel(context, () => RetroChipModel());
    retroChipModel2 = createModel(context, () => RetroChipModel());
    retroChipModel3 = createModel(context, () => RetroChipModel());
    episodeItemModel1 = createModel(context, () => EpisodeItem2Model());
    episodeItemModel2 = createModel(context, () => EpisodeItem2Model());
    episodeItemModel3 = createModel(context, () => EpisodeItem2Model());
    episodeItemModel4 = createModel(context, () => EpisodeItem2Model());
    episodeItemModel5 = createModel(context, () => EpisodeItem2Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
    retroChipModel1.dispose();
    retroChipModel2.dispose();
    retroChipModel3.dispose();
    episodeItemModel1.dispose();
    episodeItemModel2.dispose();
    episodeItemModel3.dispose();
    episodeItemModel4.dispose();
    episodeItemModel5.dispose();
  }
}
