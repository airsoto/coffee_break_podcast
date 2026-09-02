import '/components/retro_dial/retro_dial_widget.dart';
import '/components/vu_meter/vu_meter_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'now_playing_widget.dart' show NowPlayingWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NowPlayingModel extends FlutterFlowModel<NowPlayingWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for VuMeter.
  late VuMeterModel vuMeterModel1;
  // Model for VuMeter.
  late VuMeterModel vuMeterModel2;
  // Model for RetroDial.
  late RetroDialModel retroDialModel;

  @override
  void initState(BuildContext context) {
    vuMeterModel1 = createModel(context, () => VuMeterModel());
    vuMeterModel2 = createModel(context, () => VuMeterModel());
    retroDialModel = createModel(context, () => RetroDialModel());
  }

  @override
  void dispose() {
    vuMeterModel1.dispose();
    vuMeterModel2.dispose();
    retroDialModel.dispose();
  }
}
