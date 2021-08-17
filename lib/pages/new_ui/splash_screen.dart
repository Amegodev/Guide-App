import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:guide_app/utils/navigator.dart';
import 'package:guide_app/utils/theme.dart';
import 'package:guide_app/utils/tools.dart';

class NewSplashScreen extends StatefulWidget {
  @override
  _NewSplashScreenState createState() => _NewSplashScreenState();
}

class _NewSplashScreenState extends State<NewSplashScreen> {
  @override
  void initState() {
    super.initState();

    /*Future.wait(
      [
        Tools.initAppSettings(),
      ],
    ).then((value) {
      CustomNavigator.goStartScreen(context);
    });*/

    Future.delayed(Duration(seconds: 8), () {
      CustomNavigator.goStartScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkLight["dark"],
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Image.asset(
                "assets/icon.png",
                height: 120.0,
              ),
            ),
          ),
          Text(
            Tools.packageInfo.appName != ' '
                ? Tools.packageInfo.appName
                : "Loading...",
            style: MyTextStyles.bigTitleBold.apply(color: Palette.white),
          ),
          Expanded(
            flex: 2,
            child: LinearPercentIndicator(
              width: 180.0,
              lineHeight: 10.0,
              percent: 1,
              animationDuration: 8 * 1000,
              animation: true,
              alignment: MainAxisAlignment.center,
              restartAnimation: true,
              backgroundColor: Colors.white60,
              progressColor: Palette.accent,
            ),
          ),
        ],
      ),
    );
  }
}
