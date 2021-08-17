import 'package:flutter/material.dart';
import 'package:guide_app/utils/ads.dart';
import 'package:guide_app/utils/navigator.dart';
import 'package:guide_app/utils/theme.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:guide_app/widgets/custom_header.dart';
import 'package:guide_app/widgets/widgets.dart';

class SelectPlatform extends StatefulWidget {
  @override
  _SelectPlatformState createState() => _SelectPlatformState();
}

class _SelectPlatformState extends State<SelectPlatform> {
  Ads ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new Ads();
    ads.loadInter();
    customDrawer = new CustomDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
      body: Column(
        children: [
          CustomHeader(
            scaffoldKey: scaffoldKey,
            ads: ads,
            showBanner: false,
            centerWidget: Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/icon.png',
                width: Tools.width * 0.3,
              ),
            ),
            title: Tools.packageInfo.appName,
          ),
          SizedBox(
            height: Tools.width * 0.1,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Tools.height * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Select your level",
                    style: MyTextStyles.bigTitleBold,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonFilled(
                      title: Text(
                        '     LOW     ',
                        style:
                            MyTextStyles.titleBold.apply(color: Colors.white),
                      ),
                      onClicked: () {
                        ads.showInter(context);
                        CustomNavigator.goPlayScreen(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonFilled(
                      // bgColor: Colors.black,
                      bgColor: Palette.accent,
                      title: Text(
                        '   MEDIUM    ',
                        style:
                            MyTextStyles.titleBold.apply(color: Colors.white),
                      ),
                      onClicked: () {
                        ads.showInter(context);
                        CustomNavigator.goPlayScreen(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonFilled(
                      // bgColor: Colors.black,
                      bgColor: Palette.black,
                      title: Text(
                        '   HIGH    ',
                        style:
                            MyTextStyles.titleBold.apply(color: Colors.white),
                      ),
                      onClicked: () {
                        ads.showInter(context);
                        CustomNavigator.goPlayScreen(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ads.getBannerAd(),
        ],
      ),
    );
  }
}
