import 'package:flutter/material.dart';
import 'package:live_order_apps/onboarding/start_page.dart';
import 'package:live_order_apps/pages/account.dart';
import 'package:live_order_apps/pages/homepage.dart';
import 'package:live_order_apps/pages/login.dart';

class Routes {
  static const String onBoarding = '/onboarding';
  static const String home = '/home';
  static const String login = '/login';
  static const String account = "/account";
  static const String restaurant = "/restaurant";


  static Map<String, WidgetBuilder> returnRoutes = {
    onBoarding: (context) => Introduction(),
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    account: (context) => AccountPage(),
  };
}
