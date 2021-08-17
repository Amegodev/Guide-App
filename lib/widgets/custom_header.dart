import 'package:flutter/material.dart';
import 'package:guide_app/utils/ads.dart';
import 'package:guide_app/utils/theme.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:guide_app/widgets/widgets.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    Key key,
    @required this.scaffoldKey,
    this.ads,
    this.title,
    this.centerWidget,
    this.showBanner = true,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Ads ads;
  final String title;
  final Widget centerWidget;
  final bool showBanner;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: -MediaQuery.of(context).size.width * 0.8,
            child: Container(
              height: MediaQuery.of(context).size.width * 1.5,
              width: MediaQuery.of(context).size.width * 1.5,
              decoration: BoxDecoration(
                color: Palette.accent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -MediaQuery.of(context).size.width * 0.8,
            child: Container(
              height: MediaQuery.of(context).size.width * 1.485,
              width: MediaQuery.of(context).size.width * 1.485,
              decoration: BoxDecoration(
                color: Palette.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(
                  scaffoldKey: scaffoldKey,
                  bannerAd: showBanner == true ? ads.getBannerAd() : SizedBox(),
                  title: Text(
                    title,
                    style: MyTextStyles.title
                        .apply(color: Palette.white, fontFamily: 'SuezOne'),
                    textAlign: TextAlign.center,
                  ),
                  onClicked: () => ads?.showInter(context),
                ),
              ],
            ),
          ),
          Positioned(
            top: Tools.width * 0.4,
            child: centerWidget,
          ),
        ],
      ),
    );
  }
}
