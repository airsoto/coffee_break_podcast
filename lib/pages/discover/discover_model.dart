import '/components/category_chip/category_chip_widget.dart';
import '/components/podcast_card/podcast_card_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/components/trending_item/trending_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'discover_widget.dart' show DiscoverWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DiscoverModel extends FlutterFlowModel<DiscoverWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for PodcastCard.
  late PodcastCardModel podcastCardModel1;
  // Model for PodcastCard.
  late PodcastCardModel podcastCardModel2;
  // Model for PodcastCard.
  late PodcastCardModel podcastCardModel3;
  // Model for PodcastCard.
  late PodcastCardModel podcastCardModel4;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel1;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel2;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel3;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel4;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel5;
  // Model for TrendingItem.
  late TrendingItemModel trendingItemModel1;
  // Model for TrendingItem.
  late TrendingItemModel trendingItemModel2;
  // Model for TrendingItem.
  late TrendingItemModel trendingItemModel3;
  // Model for TrendingItem.
  late TrendingItemModel trendingItemModel4;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    podcastCardModel1 = createModel(context, () => PodcastCardModel());
    podcastCardModel2 = createModel(context, () => PodcastCardModel());
    podcastCardModel3 = createModel(context, () => PodcastCardModel());
    podcastCardModel4 = createModel(context, () => PodcastCardModel());
    categoryChipModel1 = createModel(context, () => CategoryChipModel());
    categoryChipModel2 = createModel(context, () => CategoryChipModel());
    categoryChipModel3 = createModel(context, () => CategoryChipModel());
    categoryChipModel4 = createModel(context, () => CategoryChipModel());
    categoryChipModel5 = createModel(context, () => CategoryChipModel());
    trendingItemModel1 = createModel(context, () => TrendingItemModel());
    trendingItemModel2 = createModel(context, () => TrendingItemModel());
    trendingItemModel3 = createModel(context, () => TrendingItemModel());
    trendingItemModel4 = createModel(context, () => TrendingItemModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    podcastCardModel1.dispose();
    podcastCardModel2.dispose();
    podcastCardModel3.dispose();
    podcastCardModel4.dispose();
    categoryChipModel1.dispose();
    categoryChipModel2.dispose();
    categoryChipModel3.dispose();
    categoryChipModel4.dispose();
    categoryChipModel5.dispose();
    trendingItemModel1.dispose();
    trendingItemModel2.dispose();
    trendingItemModel3.dispose();
    trendingItemModel4.dispose();
  }
}
