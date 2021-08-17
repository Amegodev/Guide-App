import 'package:flutter/material.dart';
import 'package:guide_app/articles.dart';
import 'package:guide_app/utils/ads.dart';
import 'package:guide_app/utils/navigator.dart';
import 'package:guide_app/utils/theme.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:guide_app/widgets/widgets.dart';

class ListGuidePage extends StatefulWidget {
  @override
  _ListGuidePageState createState() => _ListGuidePageState();
}

class _ListGuidePageState extends State<ListGuidePage> {
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
      backgroundColor: Palette.black,
      body: Column(
        children: [
          CustomAppBar(
            scaffoldKey: scaffoldKey,
            title: Text(
              Tools.packageInfo.appName,
              style: MyTextStyles.title
                  .apply(color: Palette.white, fontFamily: 'SuezOne'),
              textAlign: TextAlign.center,
            ),
            onClicked: () => ads?.showInter(context),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              padding: EdgeInsets.all(10.0),
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 10.0),
                  child: ButtonFilled(
                    bgColor: Color(0XFF424444),
                    title: Text(
                      articles[index].title,
                      style: MyTextStyles.titleBold.apply(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onClicked: () {
                      ads.showInter(context);
                      CustomNavigator.goContent(context, index);
                    },
                  ),
                );
              },
            ),
          ),
          ads.getBannerAd(),
        ],
      ),
    );
  }
}
