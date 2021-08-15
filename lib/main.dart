import 'package:flutter/material.dart';
import 'package:prank_app/pages/new_ui/splash_screen.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/utils/tools.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Tools.initAppSettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Tools.packageInfo.appName,
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat'),
      routes: routes,
      home: NewSplashScreen()/*FutureBuilder(
        future: Tools.initAppSettings().whenComplete(() => Future.delayed(Duration(seconds: 6),*() {

        })),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return NewSplashScreen();
            *//*if (snapshot.hasError) {
            Tools.logger.wtf(snapshot.error);
            return SplashScreen();
          } else
            return HomePage();*//*

          else {
            return NewStartPage();
            // return NewSplashScreen();
          }
        },
      )*/ /*SplashScreen()*/,
    );
  }
}
