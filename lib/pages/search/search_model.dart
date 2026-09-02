import '/components/category_card/category_card_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/components/trending_item2/trending_item2_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'search_widget.dart' show SearchWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchModel extends FlutterFlowModel<SearchWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for CategoryCard.
  late CategoryCardModel categoryCardModel1;
  // Model for CategoryCard.
  late CategoryCardModel categoryCardModel2;
  // Model for CategoryCard.
  late CategoryCardModel categoryCardModel3;
  // Model for CategoryCard.
  late CategoryCardModel categoryCardModel4;
  // Model for TrendingItem.
  late TrendingItem2Model trendingItemModel1;
  // Model for TrendingItem.
  late TrendingItem2Model trendingItemModel2;
  // Model for TrendingItem.
  late TrendingItem2Model trendingItemModel3;
  // Model for TrendingItem.
  late TrendingItem2Model trendingItemModel4;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    categoryCardModel1 = createModel(context, () => CategoryCardModel());
    categoryCardModel2 = createModel(context, () => CategoryCardModel());
    categoryCardModel3 = createModel(context, () => CategoryCardModel());
    categoryCardModel4 = createModel(context, () => CategoryCardModel());
    trendingItemModel1 = createModel(context, () => TrendingItem2Model());
    trendingItemModel2 = createModel(context, () => TrendingItem2Model());
    trendingItemModel3 = createModel(context, () => TrendingItem2Model());
    trendingItemModel4 = createModel(context, () => TrendingItem2Model());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    categoryCardModel1.dispose();
    categoryCardModel2.dispose();
    categoryCardModel3.dispose();
    categoryCardModel4.dispose();
    trendingItemModel1.dispose();
    trendingItemModel2.dispose();
    trendingItemModel3.dispose();
    trendingItemModel4.dispose();
  }
}
