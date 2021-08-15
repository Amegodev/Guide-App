import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:getwidget/getwidget.dart';
import 'package:logger/logger.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:prank_app/articles.dart';
import 'package:prank_app/constants.dart';
import 'package:package_info/package_info.dart';
import 'package:prank_app/models/content_model.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:prank_app/utils/ads_networks/mopub.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'ads_networks/ironsource.dart';
// import 'package:prank_app/utils/plugins/one_signal.dart';

class Tools {
  static double height = 781.0909090909091;
  static double width = 392.72727272727275;
  static AndroidDeviceInfo androidInfo;

  static Future initAppSettings() async {
    await initAppInfo();
    await getData();
    await getDeviceInfo();
    await Ads.init();
    cleanStatusBar();

    logger.i("""
    height      : $height
    width       : $width
    packageName : ${packageInfo.packageName}(${packageInfo.packageName.replaceAll('.', '_')})
    appName     : ${packageInfo.appName}
    buildNumber : ${packageInfo.buildNumber}
    version     : ${packageInfo.version}""");
  }

  static Future<void> initAppInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo = info;
  }

  static Future<void> getDeviceInfo() async {
    androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;
    Tools.logger.i(
        'Android: $release, SDK: $sdkInt, manufacturer: $manufacturer ,model: $model');
  }

  static cleanStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
  }

  static PackageInfo packageInfo = PackageInfo(
    appName: ' ',
    packageName: ' ',
    version: ' ',
    buildNumber: ' ',
  );

  static Future<void> getAppInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo = info;
  }

  static var logger = Logger(
    printer: PrettyPrinter(methodCount: 1, colors: false, prefix: true),
  );

  static Future<void> getData() async {
    if (Constants.online) {
      try {
        final response = await http.get(Uri.parse(Constants.DATA_URL));
        if (response.statusCode == 200) {
          var values = json.decode(response.body);
          Tools.logger.i(values);
          articles.clear();

          //get Data
          Constants.featuredApps =
              values["featured_apps"];
          Constants.trafficText =
              values[Tools.packageInfo.packageName]["traffic_text"];
          Constants.trafficUrl =
              values[Tools.packageInfo.packageName]["traffic_url"];
          Constants.inAppBrowser = values[Tools.packageInfo.packageName]
                          ["in_app_browser"]
                      .toString()
                      .toLowerCase() ==
                  "true"
              ? true
              : false;
          Constants.onlineArticles = values[Tools.packageInfo.packageName]
                          ["online_articles"]
                      .toString()
                      .toLowerCase() ==
                  "true"
              ? true
              : false;
          bool onlineAds = values[Tools.packageInfo.packageName]
                          ["online_ads"]
                      .toString()
                      .toLowerCase() ==
                  "true"
              ? true
              : false;
          Ads.adNetwork = values[Tools.packageInfo.packageName]["ads_mode"];

          //Fill articles
          if (Constants.onlineArticles) {
            articles = List<ContentModel>.from(
              values[Tools.packageInfo.packageName]["articles"]
                  .map((e) => ContentModel.fromJson(e)),
            );
          } else {
            for (int i = 0; i < offlineArticles.length; i++) {
              ContentModel item = new ContentModel(
                title: offlineTitles[i],
                imageUrl: "",
                content: offlineArticles[i],
              );
              articles.add(item);
            }
          }
          Tools.logger.wtf("Article length :${articles.length}");

          if (onlineAds) {
            if (Ads.adNetwork == "mopub") {
              MopubHelper.bannerAdUnit = values[Tools.packageInfo.packageName]
                  ["ads"][Ads.adNetwork]["banner"];
              MopubHelper.interAdUnit = values[Tools.packageInfo.packageName]
                  ["ads"][Ads.adNetwork]["Inter"];
              MopubHelper.rewardAdUnit = values[Tools.packageInfo.packageName]
                  ["ads"][Ads.adNetwork]["reward"];
            }
            Tools.logger.i(
                "Banner: ${MopubHelper.bannerAdUnit}\nInter: ${MopubHelper.interAdUnit}\nReward: ${MopubHelper.rewardAdUnit}");

            if (Ads.adNetwork == "ironsource") {
              IronSourceHelper.IRONSOURCE_APP_KEY =
                  values[Tools.packageInfo.packageName]["ads"][Ads.adNetwork]
                      ["app_key"];
            }
            Tools.logger
                .i("IrSource AppKey: ${IronSourceHelper.IRONSOURCE_APP_KEY}");
          }
        } else {
          Tools.logger.e('Failed to load data');
        }
      } on Exception catch (e) {
        Tools.logger.e('Failed to load data $e');
      }
      // await Ads.init();
    }
  }

  static launchURLRate() async {
    var url = 'https://play.google.com/store/apps/details?id=' +
        Tools.packageInfo.packageName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchURLMore() async {
    var url;
    if (Constants.storeId != "") {
      url = 'https://play.google.com/store/apps/dev?id=' + Constants.storeId;
    } else {
      url = 'https://play.google.com/store/apps/developer?id=' +
          Constants.storeName.split(' ').join('+');
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchTrafficUrl() async {
    final url = Constants.trafficUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<String> fetchRemoteConfig(String key) async {
    try {
      return null;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  static getRemotConfigs() async {}

  static checkAppVersion(BuildContext context) async {
    try {
      String newVersion = await fetchRemoteConfig(
              '${packageInfo.packageName.replaceAll('.', '_')}_last_version') ??
          "1.0.0";

      // newVersion = newVersion ?? "1.0.0";
      double currentVersion =
          double.parse(newVersion.trim().replaceAll(".", ""));
      double installedVersion =
          double.parse(packageInfo.version.trim().replaceAll(".", ""));

      logger.i(
          'Current version: $currentVersion \nInstalled version: $installedVersion');

      if (installedVersion < currentVersion) {
        showDialog(
          context: context,
          builder: (context) => Center(
            child: Scaffold(
              body: Center(
                child: GFFloatingWidget(
                  verticalPosition: Tools.height * 0.3,
                  showBlurness: true,
                  child: GFAlert(
                    title: 'Update available 🎉',
                    content:
                        'Version $newVersion is available to download. By downloading the latest version you will get the latest features, improvements and bug fixes.',
                    type: GFAlertType.rounded,
                    bottombar: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      new BorderRadius.circular(100.0),
                                  color: Colors.grey),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'later',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(100.0),
                                gradient: RadialGradient(
                                  colors: [Colors.amber, Colors.amber[200]],
                                  center: Alignment.bottomLeft,
                                  radius: 2.0,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Tools.launchURLRate();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'update',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  static initFireMessaging() async {}

  static openInInternalBrowser({String link, VoidCallback onClosed}) async {
    ChromeSafariBrowser browser = MyChromeSafariBrowser(() => onClosed(),
        browserFallback: InAppBrowser());
    await browser.open(
      url: link,
      options: ChromeSafariBrowserClassOptions(
        android: AndroidChromeCustomTabsOptions(
            addDefaultShareMenuItem: false, keepAliveEnabled: true),
        ios: IOSSafariOptions(
            dismissButtonStyle: IOSSafariDismissButtonStyle.CLOSE,
            presentationStyle: IOSUIModalPresentationStyle.OVER_FULL_SCREEN),
      ),
    );
  }

  static List shuffle(List items, int start, int end) {
    var random = new Random();

    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items.sublist(start, end);
  }

/*static Future<String> getCountryName() async {
    Network n = new Network("http://ip-api.com/json");
    final locationSTR = (await n.getData());
    final locationx = jsonDecode(locationSTR);
    return locationx["country"];
  }*/
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  final VoidCallback onClosed1;

  MyChromeSafariBrowser(this.onClosed1, {browserFallback})
      : super(bFallback: browserFallback);

  @override
  void onOpened() {
    // Tools.logger.i("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    // Tools.logger.i("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    this.onClosed1();
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<String> apiRequest(Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/x-www-form-urlencoded');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  Future<String> sendData(Map data) async {
    http.Response response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data));
    if (response.statusCode == 200)
      return (response.body);
    else
      return 'No Data';
  }

  Future<String> getData() async {
    http.Response response = await http.post(url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'});
    if (response.statusCode == 200)
      return (response.body);
    else
      return 'No Data';
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  Tools.logger.wtf(
      '============================= catched handler ${message['data']['imageUrl']}');
  if (message.containsKey('data')) {
// Handle data message
    final dynamic data = message['data'];
    Tools.logger
        .wtf('==================> MessageHolder (data) ' + data.toString());
  }

  if (message.containsKey('notification')) {
// Handle notification message
    final dynamic notification = message['notification'];
    Tools.logger.wtf('==================> MessageHolder (notification) ' +
        notification.toString());
  }
// Or do other work.

  return await Future.value(message);
}
