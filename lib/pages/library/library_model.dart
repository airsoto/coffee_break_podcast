import '/components/episode_item/episode_item_widget.dart';
import '/components/show_item/show_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'library_widget.dart' show LibraryWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LibraryModel extends FlutterFlowModel<LibraryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for ShowItem.
  late ShowItemModel showItemModel1;
  // Model for ShowItem.
  late ShowItemModel showItemModel2;
  // Model for ShowItem.
  late ShowItemModel showItemModel3;
  // Model for EpisodeItem.
  late EpisodeItemModel episodeItemModel1;
  // Model for EpisodeItem.
  late EpisodeItemModel episodeItemModel2;
  // Model for EpisodeItem.
  late EpisodeItemModel episodeItemModel3;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    showItemModel1 = createModel(context, () => ShowItemModel());
    showItemModel2 = createModel(context, () => ShowItemModel());
    showItemModel3 = createModel(context, () => ShowItemModel());
    episodeItemModel1 = createModel(context, () => EpisodeItemModel());
    episodeItemModel2 = createModel(context, () => EpisodeItemModel());
    episodeItemModel3 = createModel(context, () => EpisodeItemModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    showItemModel1.dispose();
    showItemModel2.dispose();
    showItemModel3.dispose();
    episodeItemModel1.dispose();
    episodeItemModel2.dispose();
    episodeItemModel3.dispose();
  }
}
