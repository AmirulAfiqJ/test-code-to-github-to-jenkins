import 'package:bizapptrack/ui/home.dart';
import 'package:bizapptrack/ui/inactive.dart';
import 'package:bizapptrack/ui/login.dart';
import 'package:bizapptrack/ui/package_dashboard.dart';
import 'package:bizapptrack/ui/support.dart';
import 'package:flutter/material.dart';

class AppRoutes {

  static String login = "/login";
  static String home = "/homepage";
  static String welcome = "/welcome";
  static String packagedashboard = "/package-dashboard";
  static String support = "/support";
  static String inactive = "/inactive";

  static Map<String, WidgetBuilder> getRoutes(){
    return {
      login: (BuildContext context) => LoginPage(),
      home: (BuildContext context) => HomePage(),
      // welcome: (BuildContext context) => 
      packagedashboard: (BuildContext context) => PackageDashboard(),
      support: (BuildContext context) => SupportPage(),
      // inactive: (BuildContext context) => Inactive(username: username)
    };
  }

}