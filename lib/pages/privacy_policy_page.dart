import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/constants.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/widgets/widgets.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();


    customDrawer = new CustomDrawer();
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
      backgroundColor: Palette.darkLight["dark"],
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -200.0,
            top: -50.0,
            child: Opacity(
              child: SvgPicture.asset(
                'assets/icons/privacy_policy.svg',
                width: 500.0,
              ),
              opacity: 0.2,
            ),
          ),
          Column(
            children: <Widget>[
              CustomAppBar(
                scaffoldKey: scaffoldKey,
                leading: IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  Constants.privacy,
                  style: MyTextStyles.bigTitleBold.apply(color:Colors.white),
                  textAlign: TextAlign.center,
                ),
                bgColor: Palette.primary,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        Constants.privacyText,
                        textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
