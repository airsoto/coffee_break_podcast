import '/components/setting_row/setting_row_widget.dart';
import '/components/stat_card/stat_card_widget.dart';
import '/components/toggle_setting/toggle_setting_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'profile_settings_widget.dart' show ProfileSettingsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileSettingsModel extends FlutterFlowModel<ProfileSettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StatCard.
  late StatCardModel statCardModel1;
  // Model for StatCard.
  late StatCardModel statCardModel2;
  // Model for StatCard.
  late StatCardModel statCardModel3;
  // Model for StatCard.
  late StatCardModel statCardModel4;
  // Model for ToggleSetting.
  late ToggleSettingModel toggleSettingModel1;
  // Model for ToggleSetting.
  late ToggleSettingModel toggleSettingModel2;
  // Model for SettingRow.
  late SettingRowModel settingRowModel1;
  // Model for SettingRow.
  late SettingRowModel settingRowModel2;
  // Model for SettingRow.
  late SettingRowModel settingRowModel3;
  // Model for SettingRow.
  late SettingRowModel settingRowModel4;
  // Model for SettingRow.
  late SettingRowModel settingRowModel5;

  @override
  void initState(BuildContext context) {
    statCardModel1 = createModel(context, () => StatCardModel());
    statCardModel2 = createModel(context, () => StatCardModel());
    statCardModel3 = createModel(context, () => StatCardModel());
    statCardModel4 = createModel(context, () => StatCardModel());
    toggleSettingModel1 = createModel(context, () => ToggleSettingModel());
    toggleSettingModel2 = createModel(context, () => ToggleSettingModel());
    settingRowModel1 = createModel(context, () => SettingRowModel());
    settingRowModel2 = createModel(context, () => SettingRowModel());
    settingRowModel3 = createModel(context, () => SettingRowModel());
    settingRowModel4 = createModel(context, () => SettingRowModel());
    settingRowModel5 = createModel(context, () => SettingRowModel());
  }

  @override
  void dispose() {
    statCardModel1.dispose();
    statCardModel2.dispose();
    statCardModel3.dispose();
    statCardModel4.dispose();
    toggleSettingModel1.dispose();
    toggleSettingModel2.dispose();
    settingRowModel1.dispose();
    settingRowModel2.dispose();
    settingRowModel3.dispose();
    settingRowModel4.dispose();
    settingRowModel5.dispose();
  }
}
