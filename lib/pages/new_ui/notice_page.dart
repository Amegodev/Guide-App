import 'package:flutter/material.dart';
import 'package:guide_app/utils/ads.dart';
import 'package:guide_app/utils/navigator.dart';
import 'package:guide_app/utils/theme.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:guide_app/widgets/custom_header.dart';
import 'package:guide_app/widgets/widgets.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
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
      resizeToAvoidBottomInset: false,
      drawer: customDrawer.buildDrawer(context),
      body: Column(
        children: [
          CustomHeader(
            scaffoldKey: scaffoldKey,
            ads: ads,
            showBanner: false,
            centerWidget: Column(
              children: [
                Text(
                  "NOTICE:",
                  style: MyTextStyles.bigTitleBold.apply(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Image.asset(
                  'assets/icon.png',
                  width: Tools.width * 0.3,
                ),
              ],
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
                    "Please, read this guide before play the game!",
                    style: MyTextStyles.bigTitleBold,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonFilled(
                      title: Text(
                        'NEXT',
                        style: MyTextStyles.titleBold.apply(color: Colors.white),
                      ),
                      onClicked: () {
                        ads.showInter(context);
                        CustomNavigator.goListGuide(context);
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
