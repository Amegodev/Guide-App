import 'package:flutter/material.dart';
import 'package:prank_app/pages/about_page.dart';
import 'package:prank_app/pages/cards_page.dart';
import 'package:prank_app/pages/content.dart';
import 'package:prank_app/pages/counter_page.dart';
import 'package:prank_app/pages/hashtags_page.dart';
import 'package:prank_app/pages/home_page.dart';
import 'package:prank_app/pages/more_apps.dart';
import 'package:prank_app/pages/new_ui/content_page.dart';
import 'package:prank_app/pages/new_ui/enter_yr_name.dart';
import 'package:prank_app/pages/new_ui/list_guide.dart';
import 'package:prank_app/pages/new_ui/notice_page.dart';
import 'package:prank_app/pages/new_ui/play_page.dart';
import 'package:prank_app/pages/new_ui/select_platform.dart';
import 'package:prank_app/pages/new_ui/start_page.dart';
import 'package:prank_app/pages/username_page.dart';
import 'package:prank_app/pages/one_more_step_page.dart';
import 'package:prank_app/pages/privacy_policy_page.dart';


class CustomNavigator {
  static void goStartScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/start', (route) => false);
  }

  static void goPlatformScreen(BuildContext context) {
    Navigator.pushNamed(context, "/platform");
  }

  static void goPlayScreen(BuildContext context) {
    Navigator.pushNamed(context, '/play');
  }

  static void goEnterNamePage(BuildContext context) {
    Navigator.pushNamed(context, "/name");
  }

  static void goPlayAndEarn(BuildContext context) {
    Navigator.pushNamed(context, "/earn");
  }

  static void goNoticePage(BuildContext context) {
    Navigator.pushNamed(context, '/notice');
  }

  static void goListGuide(BuildContext context) {
    Navigator.pushNamed(context, '/list_guide');
  }

  static void goContent(BuildContext context, int position) {
    Navigator.pushNamed(context, '/content', arguments: position);
  }

  static void moreApps(BuildContext context) {
    Navigator.pushNamed(context, '/moreApps');
  }

  static void goPrivacy(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }

  static void goAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  static void goUserNamePage(BuildContext context) {
    Navigator.pushNamed(context, "/username");
  }

  static void goCards(BuildContext context, String username) {
    Navigator.pushNamed(context, '/cards', arguments: {"username": username});
  }

  static void goCounter(BuildContext context, String username, String totalPoints) {
    Navigator.pushNamed(context, '/counter', arguments: {"username": username, "totalPoints" : totalPoints});
  }

  static void goOneMoreStep(BuildContext context, String username, String totalPoints) {
    Navigator.pushNamed(context, '/oneMoreStep', arguments: {"username": username, "totalPoints" : totalPoints});
  }

  static void goHashtags(BuildContext context, String username, String totalPoints) {
    Navigator.pushNamed(context, '/hashtags', arguments: {"username": username, "totalPoints" : totalPoints});
  }
}

var routes = <String, WidgetBuilder>{
  '/start': (BuildContext context) => NewStartPage(),
  "/platform": (BuildContext context) => SelectPlatform(),
  "/play": (BuildContext context) => PlayPage(),
  "/name": (BuildContext context) => EnterNamePage(),
  "/earn": (BuildContext context) => UsernamePage(),
  "/notice": (BuildContext context) => NoticePage(),
  "/list_guide": (BuildContext context) => ListGuidePage(),
  "/content": (BuildContext context) => ContentPage(),
  '/moreApps': (BuildContext context) => MoreApps(),
  "/privacy": (BuildContext context) => PrivacyPolicyPage(),
  "/about": (BuildContext context) => AboutPage(),


  "/username": (BuildContext context) => UsernamePage(),
  "/cards": (BuildContext context) => CardsPage(),
  "/counter": (BuildContext context) => CounterPage(),
  "/oneMoreStep": (BuildContext context) => OneMoreStep(),
  "/hashtags": (BuildContext context) => HashtagsPage(),
};


class MyNavigator {
  static void goHome(BuildContext context) {
//    Navigator.pushReplacementNamed(context, "/home");
    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
  }

  static void start(BuildContext context) {
    Navigator.pushNamed(context, '/start');
  }

  static void goUserNamePage(BuildContext context) {
    Navigator.pushNamed(context, "/username");
  }

  static void goCards(BuildContext context, String username) {
    Navigator.pushNamed(context, '/cards', arguments: {"username": username});
  }

  static void goCounter(BuildContext context, String username, String totalPoints) {
    Navigator.pushNamed(context, '/counter', arguments: {"username": username, "totalPoints" : totalPoints});
  }

  static void goOneMoreStep(BuildContext context, String username, String totalPoints) {
    Navigator.pushNamed(context, '/oneMoreStep', arguments: {"username": username, "totalPoints" : totalPoints});
  }

  static void goHashtags(BuildContext context, String username, String totalPoints) {
    Navigator.pushNamed(context, '/hashtags', arguments: {"username": username, "totalPoints" : totalPoints});
  }

  static void moreApps(BuildContext context) {
    Navigator.pushNamed(context, '/moreApps');
  }

  static void goPrivacy(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }

  static void goAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }
}

var oldRoutes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
  '/play': (BuildContext context) => ContentScreen(),
  "/username": (BuildContext context) => UsernamePage(),
  "/cards": (BuildContext context) => CardsPage(),
  "/counter": (BuildContext context) => CounterPage(),
  "/oneMoreStep": (BuildContext context) => OneMoreStep(),
  "/hashtags": (BuildContext context) => HashtagsPage(),
  '/moreApps': (BuildContext context) => MoreApps(),
  "/privacy": (BuildContext context) => PrivacyPolicyPage(),
  "/about": (BuildContext context) => AboutPage(),
};
