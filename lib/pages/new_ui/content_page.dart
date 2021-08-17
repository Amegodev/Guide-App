import 'package:page_slider/page_slider.dart';
import 'package:guide_app/articles.dart';
import 'package:guide_app/utils/ads.dart';
import 'package:guide_app/utils/theme.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:guide_app/widgets/dialogs.dart';
import 'package:guide_app/widgets/widgets.dart';

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  Ads ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  GlobalKey<PageSliderState> _sliderKey = GlobalKey();
  String previous = "Quite";
  String next = "Next";

  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    ads = new Ads();
    customDrawer = new CustomDrawer();

    scrollController = new ScrollController();
    ads.loadInter();
    ads.loadReward();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as int;

    setState(() {
      if (args == 0)
        previous = "Quite";
      else
        previous = "Previous";
      if (args != articles.length - 1)
        next = "Next";
      else
        next = "Replay";
    });

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Palette.darkLight["dark"],
      drawer: customDrawer.buildDrawer(context),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageSlider(
            key: _sliderKey,
            initialPage: args,
            pages: articles.map((element) {
              return Scrollbar(
                isAlwaysShown: true,
                controller: scrollController,
                radius: Radius.circular(100.0),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, left: 10.0, top: 110, bottom: 80),
                      child: HtmlWidget(
                        element.content,
                        customWidgetBuilder: (element) {
                          if (element.id.contains("NativeAd"))
                            return ads.getNativeAd();
                          else if (element.id.contains("rate"))
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ButtonFilled(
                                // bgColor: Colors.black,
                                bgColor: Palette.white,
                                title: Text(
                                  'Click here to Rate\n⭐⭐⭐⭐⭐',
                                  style: MyTextStyles.titleBold
                                      .apply(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                onClicked: () async {
                                  int count = await showDialog(
                                      context: context,
                                      builder: (_) => RatingDialog());
                                  if (count != null && count <= 3)
                                    ads.showInter(context);
                                },
                              ),
                            );
                          else
                            return null;
                        },
                        hyperlinkColor: Colors.lightBlueAccent,
                        textStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          CustomAppBar(
            scaffoldKey: scaffoldKey,
            bannerAd: ads.getBannerAd(),
            bgColor: Palette.darkLight["dark"].withOpacity(0.9),
            title: Text(
              Tools.packageInfo.appName,
              style: MyTextStyles.title
                  .apply(color: Palette.white, fontFamily: 'SuezOne'),
              textAlign: TextAlign.center,
            ),
            onClicked: () => ads?.showInter(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Palette.darkLight["dark"].withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonFilled(
                          bgColor: Palette.white,
                          title: Text(
                            previous,
                            style: MyTextStyles.titleBold
                                .apply(fontFamily: 'SuezOne'),
                          ),
                          onClicked: () async {
                            Tools.logger.wtf(
                                "Page: ${_sliderKey.currentState.currentPage}");
                            if (_sliderKey.currentState.hasPrevious) {
                              if (_sliderKey.currentState.currentPage == 1) {
                                setState(() {
                                  previous = "Quite";
                                });
                              }
                              if (_sliderKey.currentState.currentPage ==
                                  articles.length - 1) {
                                setState(() {
                                  next = "Next";
                                });
                              }
                              _sliderKey.currentState.previous();
                              if (_sliderKey.currentState.currentPage % 2 ==
                                  0) {}
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonFilled(
                          bgColor: Palette.white,
                          title: Text(
                            next,
                            style: MyTextStyles.titleBold
                                .apply(fontFamily: 'SuezOne'),
                          ),
                          onClicked: () async {
                            Tools.logger.wtf(
                                "Page: ${_sliderKey.currentState.currentPage}");
                            Tools.logger.i(
                                "currentPage: ${_sliderKey.currentState.currentPage}\narticles.length: ${articles.length}");
                            if (_sliderKey.currentState.hasNext) {
                              if (_sliderKey.currentState.currentPage ==
                                  articles.length - 2) {
                                next = "Replay";
                              } else {
                                if (next != "next") {
                                  next = "next";
                                }
                              }
                              if (_sliderKey.currentState.currentPage == 0) {
                                previous = "Previous";
                              }
                              if (_sliderKey.currentState.currentPage % 2 ==
                                  0) {
                                ads.showInter(context);
                              }
                              setState(() {});
                              _sliderKey.currentState.next();
                            } else {
                              await ads.showRewardAd();
                              setState(() {
                                Tools.logger.wtf("Page: last");
                                next = "Next";
                                previous = "Quite";
                              });
                              _sliderKey.currentState.setPage(0);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
