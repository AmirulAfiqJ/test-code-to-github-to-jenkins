import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String username = "";

  Future getPref(context) async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    username = args["username"];
    notifyListeners();
  }
}