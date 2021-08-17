import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:guide_app/utils/ads.dart';
import 'package:guide_app/utils/navigator.dart';
import 'package:guide_app/utils/theme.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:guide_app/widgets/custom_header.dart';
import 'package:guide_app/widgets/dialogs.dart';
import 'package:guide_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  Ads ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  Widget bannerAd;


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Tools.logger.wtf("HomePage LifeCycle : $state");
    switch (state) {
      case AppLifecycleState.resumed:
        IronSource.activityResumed();
        setState(() {
          bannerAd = ads.getBannerAd();
        });
        break;
      case AppLifecycleState.inactive:
      // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
      // TODO: Handle this case.
        IronSource.activityPaused();
        ads.hideBannerAd();
        break;
      case AppLifecycleState.detached:
      // TODO: Handle this case.
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    ads = new Ads();
    ads.loadInter();
    customDrawer = new CustomDrawer();
    bannerAd = ads.getBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomHeader(
                scaffoldKey: scaffoldKey,
                ads: ads,
                centerWidget: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/icon.png',
                    width: Tools.width * 0.2,
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonFilled(
                        title: Text(
                          '🤔 Start Walkthrough 💭',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.white),
                        ),
                        onClicked: () {
                          ads.showInter(context);
                          MyNavigator.start(context);
                        },
                      ),
                    ),
                    Text(
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
                          '🛒 Play And Earn 🎉',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.white),
                        ),
                        onClicked: () {
                          ads.showInter(context);
                          MyNavigator.goUserNamePage(context);
                        },
                      ),
                    ),
                    Text(
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
                        bgColor: Palette.white,
                        title: Text(
                          '😍 Rate us ⭐',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.black),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
