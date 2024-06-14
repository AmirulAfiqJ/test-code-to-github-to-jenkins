import 'dart:core';

class Env {
  static String baseUrl =
      "https://corrad.visionice.net/bizapp/apigenerator_VERSIX.php?";

  static String baseBackOfficeUrl =
      "https://corrad.visionice.net/bizapp/backoffice/dashboard/api.php";

  static String versi = "2.9.1";

  static String cariapa = "abc280801zz!";

  static String get loginurl => "${baseUrl}api_name=TRACK_LOGIN";

  static String get statisticurl =>
      "${baseUrl}api_name=TRACK_GET_STATISTICS&TX=";

  static String get rekodurl =>
      "${baseUrl}api_name=TRACK_LIST_DONETRACKINGNO&TX=";

  static String get profileurl => "${baseUrl}api_name=TRACK_GET_PROFILE&TX=";

  static String get statusShopee =>
      "https://corrad.visionice.net/bizapp/apigenerator_shopee.php?api_name=TRACK_GET_SHOPEE_SETTING&TX=";

  static String get statusTiktok =>
      "https://corrad.visionice.net/bizapp/apigenerator_tiktokshop.php?api_name=TRACK_GET_TIKTOKSHOP_SETTING&TX=";
      
  static String get Wsapme =>
      "https://corrad.visionice.net/bizapp/apigenerator_wsapme.php?api_name=TRACK_GET_WSAPME_ACCOUNT&TX=";

  static String get bizappage =>
      "${baseUrl}api_name=TRACK_GET_LISTOFSALESPAGE_BY_HQ&TX=";

  static String get woocommerce =>
      "${baseUrl}api_name=TRACK_GET_PROFILE_OWNWOO&TX=";

  static String get totalorders =>
      "$baseBackOfficeUrl?domain=bizapp&summary=total-orders";
}
