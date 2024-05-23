import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier {
  final key = new GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  List<LoginList> loginList = [
    LoginList(email: "admin", password: "admin", username: "Admin"),
    LoginList(
        email: "khai@bizapp.my", password: "khaibiz", username: "Khairina"),
    LoginList(email: "miza@bizapp.my", password: "mizabiz", username: "Miza"),
    LoginList(
        email: "zurah@bizapp.my", password: "zurahbiz", username: "Zurah"),
  ];
}

class LoginList {
  String email;
  String password;
  String username;

  LoginList({
    required this.email,
    required this.password,
    required this.username,
  });
}


