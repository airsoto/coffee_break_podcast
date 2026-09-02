import '/components/category_chip/category_chip_widget.dart';
import '/components/podcast_card/podcast_card_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/components/trending_item/trending_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'discover_model.dart';
export 'discover_model.dart';

class DiscoverWidget extends StatefulWidget {
  const DiscoverWidget({super.key});

  static String routeName = 'Discover';
  static String routePath = '/discover';

  @override
  State<DiscoverWidget> createState() => _DiscoverWidgetState();
}

class _DiscoverWidgetState extends State<DiscoverWidget> {
  late DiscoverModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DiscoverModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).onPrimary,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tertiary,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 40.0, 24.0, 24.0),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SONICSTREAM',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.outfit(
                                              fontWeight: FontWeight.w900,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimaryContainer,
                                            fontSize: 32.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w900,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                            lineHeight: 1.0,
                                          ),
                                    ),
                                    Text(
                                      'THE ANALOG FEEL OF DIGITAL SOUND',
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.outfit(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimaryContainer70,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                            lineHeight: 1.3,
                                          ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    borderRadius: BorderRadius.circular(8.0),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimaryContainer,
                                      width: 3.0,
                                    ),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .onPrimaryContainer,
                                    size: 24.0,
                                  ),
                                ),
                              ],
                            ),
                            wrapWithModel(
                              model: _model.textFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: TextFieldWidget(
                                label: '',
                                labelPresent: false,
                                helper: '',
                                helperPresent: false,
                                leadingIcon: Icon(
                                  Icons.search_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                leadingIconPresent: true,
                                trailingIconPresent: false,
                                hint: 'Search shows, episodes...',
                                value: '',
                                onChange: '',
                                onSubmit: '',
                                variant: 'filled',
                                error: false,
                              ),
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ),
                    ),
                    Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).onPrimaryContainer,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Trending Now',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.spaceGrotesk(
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  color: Colors.black,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          Text(
                            'SEE ALL',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Colors.black,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.podcastCardModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PodcastCardWidget(
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/vintage%20coffee%20shop%20interior%20aesthetic',
                                      subtitle: 'Coffee & Code',
                                      title: 'The Daily Grind',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.podcastCardModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PodcastCardWidget(
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/80s%20synthwave%20grid%20landscape',
                                      subtitle: 'Tech from Tomorrow',
                                      title: 'Retro Future',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.podcastCardModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PodcastCardWidget(
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/close%20up%20of%20vinyl%20record%20grooves',
                                      subtitle: 'Deep Cuts Only',
                                      title: 'Vinyl Only',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.podcastCardModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: PodcastCardWidget(
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/vintage%20haunted%20house%20illustration',
                                      subtitle: 'Spooky Stories',
                                      title: 'Midnight Tales',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                wrapWithModel(
                                  model: _model.categoryChipModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CategoryChipWidget(
                                    label: 'TRUE CRIME',
                                    selected: true,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.categoryChipModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CategoryChipWidget(
                                    label: 'COMEDY',
                                    selected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.categoryChipModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CategoryChipWidget(
                                    label: 'TECH',
                                    selected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.categoryChipModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CategoryChipWidget(
                                    label: 'MUSIC',
                                    selected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.categoryChipModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CategoryChipWidget(
                                    label: 'HISTORY',
                                    selected: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Top Episodes',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            font: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.w900,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontStyle,
                            ),
                            color: Colors.black,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        wrapWithModel(
                          model: _model.trendingItemModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: TrendingItemWidget(
                            duration: '45 min',
                            imgDesc:
                                'https://dimg.dreamflow.cloud/v1/image/record%20player%20close%20up',
                            name: 'The Vinyl Revival',
                            show: 'SonicStream Originals',
                          ),
                        ),
                        wrapWithModel(
                          model: _model.trendingItemModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: TrendingItemWidget(
                            duration: '32 min',
                            imgDesc:
                                'https://dimg.dreamflow.cloud/v1/image/modular%20synthesizer%20knobs',
                            name: 'Analog Synthesis 101',
                            show: 'The Synth Guide',
                          ),
                        ),
                        wrapWithModel(
                          model: _model.trendingItemModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: TrendingItemWidget(
                            duration: '58 min',
                            imgDesc:
                                'https://dimg.dreamflow.cloud/v1/image/abstract%20sound%20waves%20vintage',
                            name: 'Why We Listen',
                            show: 'Audio Philosophy',
                          ),
                        ),
                        wrapWithModel(
                          model: _model.trendingItemModel4,
                          updateCallback: () => safeSetState(() {}),
                          child: TrendingItemWidget(
                            duration: '120 min',
                            imgDesc:
                                'https://dimg.dreamflow.cloud/v1/image/lofi%20hip%20hop%20aesthetic%20girl',
                            name: 'Lo-Fi Beats to Code',
                            show: 'Chill Station',
                          ),
                        ),
                      ].divide(SizedBox(height: 0.0)),
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.0,
                          color:
                              FlutterFlowTheme.of(context).onPrimaryContainer27,
                          offset: Offset(
                            6.0,
                            6.0,
                          ),
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(24.0),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).onPrimaryContainer,
                        width: 3.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                                borderRadius: BorderRadius.circular(9999.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .onPrimaryContainer,
                                  width: 2.0,
                                ),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.graphic_eq_rounded,
                                color: FlutterFlowTheme.of(context)
                                    .onPrimaryContainer,
                                size: 24.0,
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
                                    'Ready to play?',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight: FontWeight.w800,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                          lineHeight: 1.45,
                                        ),
                                  ),
                                  Text(
                                    'Jump back into your last session',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.outfit(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: Color(0xCCFFFFFF),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.3,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ].divide(SizedBox(width: 16.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
