import 'package:flutter/material.dart';
import 'package:guide_app/utils/ads.dart';
import 'package:guide_app/utils/navigator.dart';
import 'package:guide_app/utils/theme.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:guide_app/widgets/custom_header.dart';
import 'package:guide_app/widgets/dialogs.dart';
import 'package:guide_app/widgets/widgets.dart';

class NewStartPage extends StatefulWidget {
  @override
  _NewStartPageState createState() => _NewStartPageState();
}

class _NewStartPageState extends State<NewStartPage> {

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
            height: Tools.width * 0.2,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonFilled(
                    title: Text(
                      '🟢 Start ▶',
                      style:
                      MyTextStyles.titleBold.apply(color: Colors.white),
                    ),
                    onClicked: () {
                      ads.showInter(context);
                      CustomNavigator.goPlatformScreen(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonFilled(
                      // bgColor: Colors.black,
                      bgColor: Palette.accent,
                      title: Text(
                        '🛒 Play And Earn 🎉',
                        style:
                        MyTextStyles.titleBold.apply(color: Colors.black),
                      ),
                      onClicked: () {
                        ads.showInter(context);
                        CustomNavigator.goPlayAndEarn(context);
                      },
                    ),
                  ),Text(
                    "Or",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonFilled(
                      // bgColor: Colors.black,
                      bgColor: Palette.black,
                      title: Text(
                        '😍 Rate us ⭐',
                        style:
                        MyTextStyles.titleBold.apply(color: Palette.accent),
                      ),
                      onClicked: () async {
                        int count = await showDialog(
                            context: context, builder: (_) => RatingDialog());
                        if (count != null && count <= 3)
                          ads.showInter(context);
                      },
                    ),
                  ),
                ],
            ),
          ),
          ads.getBannerAd(),
        ],
      ),
    );
  }
}