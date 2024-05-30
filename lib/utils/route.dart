import 'package:bizapptrack/ui/home.dart';
import 'package:flutter/material.dart';

class AppRoutes {

  static String login = "/login";
  static String home = "/homepage";
  static String welcome = "/welcome";

  static Map<String, WidgetBuilder> getRoutes(){
    return {
      login: (BuildContext context) => Login(),
      home: (BuildContext context) => HomePage(),
    };
  }

}