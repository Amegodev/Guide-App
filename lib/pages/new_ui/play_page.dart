import 'package:flutter/material.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:prank_app/widgets/custom_header.dart';
import 'package:prank_app/widgets/widgets.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonFilled(
                      title: Text(
                        'PLAY',
                        style: MyTextStyles.titleBold.apply(color: Colors.white),
                      ),
                      onClicked: () {
                        ads.showInter(context);
                        CustomNavigator.goEnterNamePage(context);
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