import 'dart:core';

class Env {
  static String baseUrl =
      "https://corrad.visionice.net/bizapp/apigenerator_VERSIX.php?";

  static String versi = "2.9.1";

  static String cariapa = "abc280801zz";

  static String get loginurl => "${baseUrl}api_name=TRACK_LOGIN";

  static String get statisticurl =>
      "${baseUrl}api_name=TRACK_GET_STATISTICS&TX=";

  static String get rekodurl =>
      "${baseUrl}api_name=TRACK_LIST_DONETRACKINGNO&TX=";

  static String get profileurl => "${baseUrl}api_name=TRACK_GET_PROFILE&TX=";
}
