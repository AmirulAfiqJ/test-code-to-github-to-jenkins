import 'package:bizapptrack/ui/expiring.dart';
import 'package:bizapptrack/ui/home.dart';
import 'package:bizapptrack/ui/inactive.dart';
import 'package:bizapptrack/ui/login.dart';
import 'package:bizapptrack/ui/newRenew.dart';
import 'package:bizapptrack/ui/others.dart';
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
  static String newRenew = "/new-renew";
  static String expiring = "/expiring";
  static String others = "/others";

  static Map<String, WidgetBuilder> getRoutes(){
    return {
      login: (BuildContext context) => LoginPage(),
      home: (BuildContext context) => HomePage(),
      // welcome: (BuildContext context) => 
      packagedashboard: (BuildContext context) => PackageDashboard(),
      support: (BuildContext context) => SupportPage(),
      inactive: (BuildContext context) => Inactive(),
      newRenew: (BuildContext context) => NewCustomer(),
      expiring: (BuildContext context) => Expiring(),
      others: (BuildContext context) => Others()
    };
  }

}