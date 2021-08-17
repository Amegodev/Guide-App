import 'package:flutter/material.dart';
import 'package:guide_app/utils/ads.dart';
import 'package:guide_app/utils/navigator.dart';
import 'package:guide_app/utils/theme.dart';
import 'package:guide_app/utils/tools.dart';
import 'package:guide_app/widgets/custom_header.dart';
import 'package:guide_app/widgets/widgets.dart';

class EnterNamePage extends StatefulWidget {
  @override
  _EnterNamePageState createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  Ads ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  TextEditingController usernameTextController = new TextEditingController();

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
            centerWidget: Text(
              "Enter Your Name",
              style: MyTextStyles.bigTitleBold.apply(
                color: Palette.accent,
              ),
            ),
            title: Tools.packageInfo.appName,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Tools.height * 0.25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Palette.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: TextField(
                        controller: usernameTextController,
                        keyboardType: TextInputType.text,
                        style: MyTextStyles.titleBold,
                        decoration: InputDecoration(
                          fillColor: Palette.accent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          hintText: 'Ex: Jack',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(8.0),
                          suffix: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.black,
                            ),
                            child: InkWell(
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 10.0,
                              ),
                              onTap: () => usernameTextController.clear(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonFilled(
                      title: Text(
                        'CONTINUE',
                        style:
                            MyTextStyles.titleBold.apply(color: Colors.white),
                      ),
                      onClicked: () async {
                        if (usernameTextController.text.isNotEmpty) {
                          CustomNavigator.goNoticePage(context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text('Attention!'),
                                  content: Text(
                                      'Invalid username 🙁\nPlease enter a valid username first.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
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
