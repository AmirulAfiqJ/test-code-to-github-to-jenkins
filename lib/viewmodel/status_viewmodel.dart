import 'dart:async';
import 'dart:html';
import 'package:bizapptrack/model/listrekodmodel.dart';
import 'package:bizapptrack/ui/home.dart';
import 'package:bizapptrack/utils/constant.dart';
import 'package:bizapptrack/env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bizapptrack/model/SpecificTotalSubs.dart';

class StatusController extends ChangeNotifier {
  String username = "";
  String usernameUser = "";
  String sk = "";
  String nama = "";
  String emel = "";
  String nohp = "";
  String roleid = "";
  String tarikhnaiktaraf = "";
  String tarikhtamat = "";
  String tarikhlogmasuk = "";
  String basicplusonly = "";
  String pid = "";

  String biltempahan = "";
  String rekodtempahan = "";
  String bilEjen = "";
  String bizappayacc = "";
  String jenissyarikatname = "";
  String bizappage = "";
  String statusTiktok = "-";
  String statusShopee = "-";
  String woo = "-";
  String wsapme = "-";
  String typepayment = "";
  String transactdate = "";

  int today = 0;
  int ystd = 0;
  int week = 0;
  int month = 0;
  int year = 0;

  int todayult1 = 0;
  int ystdult1 = 0;
  int weekult1 = 0;
  int monthult1 = 0;
  int yearult1 = 0;

  int todayult12 = 0;
  int ystdult12 = 0;
  int weekult12 = 0;
  int monthult12 = 0;
  int yearult12 = 0;

  bool call = false;
  bool callDedagang = false;
  bool callRekod = false;

  Future getPref(context) async {
  final args = ModalRoute.of(context)!.settings.arguments as Map;
  usernameUser = args["username"];
  notifyListeners();
  }

  Future loginServices(BuildContext context, {required String userid}) async {
    Map<String, dynamic> body = {
      "username": userid,
      "password": Env.cariapa,
      "DOMAIN": "BIZAPP",
      "platform": "Android",
      "lastseenversion": "",
      "FCM_TOKEN": "",
      "regid": ""
    };

    await http.post(Uri.parse(Env.loginurl), body: body).then((res) async {
      final resJSON = json.decode(res.body);
      call = false;
      notifyListeners();

      callDedagang = true;
      notifyListeners();

      /// check de dagang
      _dedagang(resJSON[0]['pid']).onError((error, stackTrace) {
        callDedagang = false;
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBarBizapp("error dedagang"));
      });

      _getRekod(resJSON[0]['pid']);

      var report = resJSON[0]['addon_module_rpt'];

      /// to check bizapp package
      var pakej = "";
      resJSON[0]['roleid'] == "0" && report == "0"
          ? pakej = "Basic"
          : resJSON[0]['roleid'] == "0" && report == "1"
              ? pakej = "Basic+"
              : resJSON[0]['roleid'] == "1"
                  ? pakej = "Pro"
                  : resJSON[0]['roleid'] == "2"
                      ? pakej = "Pro"
                      : resJSON[0]['roleid'] == "3"
                          ? pakej = "Ultimate"
                          : pakej = resJSON[0]['roleid'];

      /// to check bizappay account
      var accbizappay = "";
      resJSON[0]['accountBIZAPPAY'] == "Y"
          ? accbizappay = "Ya"
          : accbizappay = "Tiada";

      pid = resJSON[0]['pid'];
      sk = resJSON[0]['secretkey'];
      username = resJSON[0]['penggunaid'];
      nama = resJSON[0]['nama'];
      roleid = pakej;
      tarikhnaiktaraf = resJSON[0]['tarikhnaiktaraf'];
      tarikhtamat = resJSON[0]['tarikhtamattempoh'];
      bizappayacc = accbizappay;
      basicplusonly = resJSON[0]['addon_module_rpt_display'];
      basicplusonly = basicplusonly == "" || basicplusonly.isEmpty
          ? basicplusonly = "-"
          : basicplusonly.replaceAll("<br>", " ");
      notifyListeners();

      return resJSON[0];
    }).onError((error, stackTrace) {
      call = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(snackBarBizapp("error login"));
    });
  }

  Future profile(BuildContext context, {required String pid}) async {
    Map<String, dynamic> body = {
      "pid": pid,
      "DOMAIN": "BIZAPP",
      "TOKEN": " ",
    };

    await http.post(Uri.parse(Env.profileurl), body: body).then((res) async {
      final resJSON = json.decode(res.body);
      call = false;

      jenissyarikatname = resJSON[0]['jenissyarikat'];
      emel = resJSON[0]['emel'];
      nohp = resJSON[0]['nohp'];
      notifyListeners();

      return resJSON[0];
    }).onError((error, stackTrace) {
      call = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future statushopee(BuildContext context, {required String pid}) async {
    Map<String, dynamic> body = {
      "pid": pid,
      "DOMAIN": "BIZAPP",
      "TOKEN": " ",
    };

    await http.post(Uri.parse(Env.statusShopee), body: body).then((res) async {
      final resJSON = json.decode(res.body);
      call = false;

      resJSON[0]['shopee_connection'] == "1"
          ? statusShopee = "Connected"
          : statusShopee = "Disconnected";
      // print(resJSON[0]);
      notifyListeners();

      return resJSON[0];
    }).onError((error, stackTrace) {
      call = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future statustiktok(BuildContext context, {required String pid}) async {
    Map<String, dynamic> body = {
      "pid": pid,
      "DOMAIN": "BIZAPP",
      "TOKEN": " ",
    };

    await http.post(Uri.parse(Env.statusTiktok), body: body).then((res) async {
      final resJSON = json.decode(res.body);
      call = false;

      resJSON[0]['tiktokshop_connection'] == "1"
          ? statusTiktok = "Connected"
          : statusTiktok = "Disconnected";
      // print(resJSON[0]);
      notifyListeners();

      return resJSON[0];
    }).onError((error, stackTrace) {
      call = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future statusWsapme(BuildContext context, {required String pid}) async {
    Map<String, dynamic> body = {
      "pid": pid,
      "DOMAIN": "BIZAPP",
    };

    await http.post(Uri.parse(Env.Wsapme), body: body).then((res) async {
      final resJSON = json.decode(res.body);
      call = false;

      resJSON[0]['STATUS'] == "1"
          ? wsapme = "Connected"
          : wsapme = "Disconnected";
      // print(resJSON[0]);
      notifyListeners();

      return resJSON[0];
    }).onError((error, stackTrace) {
      call = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future bizappPage(BuildContext context,
      {required String pid, required String hqpid}) async {
    Map<String, dynamic> body = {
      "pid": pid,
      "hqpid": hqpid,
      "DOMAIN": "BIZAPP",
      "TOKEN": " ",
    };

    await http.post(Uri.parse(Env.bizappage), body: body).then((res) async {
      final resJSON = json.decode(res.body);
      call = false;

      bizappage = resJSON[0]['url'];
      notifyListeners();

      return resJSON[0];
    }).onError((error, stackTrace) {
      call = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future wooCom(BuildContext context, {required String pid}) async {
    Map<String, dynamic> body = {
      "pid": pid,
      "DOMAIN": "BIZAPP",
      "TOKEN": "aa",
    };

    await http.post(Uri.parse(Env.woocommerce), body: body).then((res) {
      final resJSON = json.decode(res.body);

      resJSON[0]['STATUS'] == "1" ? woo = "Active" : woo = "Inactive";

      notifyListeners();
    });
  }

  void resetData() {
    username = "";
    sk = "";
    nama = "";
    emel = "";
    nohp = "";
    roleid = "";
    tarikhnaiktaraf = "";
    tarikhtamat = "";
    tarikhlogmasuk = "";
    basicplusonly = "";
    biltempahan = "-";
    rekodtempahan = "-";
    bilEjen = "-";
    bizappayacc = "-";
    jenissyarikatname = "-";
    statusTiktok = "-";
    statusShopee = "-";
    wsapme = "-";
    woo = "-";
    typepayment = "";
    transactdate = "";

    today = 0;
    ystd = 0;
    week = 0;
    month = 0;
    year = 0;

    todayult1 = 0;
    ystdult1 = 0;
    weekult1 = 0;
    monthult1 = 0;
    yearult1 = 0;

    todayult12 = 0;
    ystdult12 = 0;
    weekult12 = 0;
    monthult12 = 0;
    yearult12 = 0;

    call = false;
    callDedagang = false;
    callRekod = false;
    notifyListeners();
  }

  String dedagang = "-";
  Future _dedagang(String pid) async {
    Map<String, dynamic> body = {
      "pid": pid,
      "DOMAIN": "BIZAPP",
      "TOKEN": "aa",
    };

    await http.post(Uri.parse(Env.statisticurl), body: body).then((res) {
      final resJSON = json.decode(res.body);
      callDedagang = false;
      var x = resJSON[0]['dedagang_offer'];
      x == "0" ? dedagang = "No" : dedagang = "Yes";

      biltempahan = resJSON[0]['TOTALORDER'];
      biltempahan = biltempahan.replaceAll(",", "");
      rekodtempahan = resJSON[0]['TOTALORDERDONE'];
      bilEjen = resJSON[0]['COUNTAGENT'];
      notifyListeners();
    });
  }

  listRekodModel? listrekodmodel;

  // final List<listRekodModel> listrekod = [];
  // Future<listRekodModel?> _getRekod(String pid) async {
  final List listrekod = [];
  Future _getRekod(String pid) async {
    Map<String, dynamic> body = {
      "pid": pid,
      "DOMAIN": "BIZAPP",
      "TOKEN": "aa",
      "sk": sk,
      "tahuntahun": "",
      "statusparcel_noorder": "",
      "jenissort": "0",
      "loadsemua": "NO",
      "start": "0",
    };

    callRekod = true;
    listrekod.clear();
    notifyListeners();

    final res =
        await http.post(Uri.parse(Env.rekodurl), body: body).then((res) {
      final resJSON = json.decode(res.body);
      // listrekod.add(listRekodModel.fromJson(resJSON));
      // listrekodmodel = listRekodModel.fromJson(jsonDecode(res.body));
      callRekod = false;
      typepayment = resJSON[0]['camefrom'] ?? "null";
      // print("test: ${listrekod}");
      if (resJSON[0]["camefrom"] == "WOO") {
        typepayment = "WooCommerce";
      } else if (resJSON[0]["camefrom"] == "EMALL") {
        typepayment = "Bizappshop (Minishop)";
      } else if (resJSON[0]["fpxkey"] == "DONE") {
        typepayment = "Bizappay";
      } else {
        typepayment = "Manual";
      }

      transactdate = resJSON[0]['transactiondate'];
      // listrekod.addAll(res.listmodel);
      listrekod.addAll(resJSON);
      // print(resJSON[0]);
      notifyListeners();
    });
  }

  // method for Total Active User
  Future<void> totalactiveuser(BuildContext context) async {
    Map<String, dynamic> body = {
      "domain": "BIZAPP",
      "summary": "total-active-user",
    };

    try {
      final res = await http.get(
        Uri.parse(Env.useractive),
      );

      if (res.statusCode == 200) {
        final resJSON = json.decode(res.body);
        today = resJSON['resultData']['total-active-user']['today'] ?? 0;
        ystd = resJSON['resultData']['total-active-user']['yesterday'] ?? 0;
        week = resJSON['resultData']['total-active-user']['this_week'] ?? 0;
        month = resJSON['resultData']['total-active-user']['this_month'] ?? 0;
        year = resJSON['resultData']['total-active-user']['this_year'] ?? 0;
      } else {
        print('Error: ${res.statusCode}, Response: ${res.body}');
      }
    } catch (e) {
      print('Error: $e');
    }

    notifyListeners();
  }

  Map<String, List<dynamic>> getDataAU() {
    return {
      'Total Active User': [today, ystd, week, month],
    };
  }

  Map<String, List<dynamic>> getDataYearAU() {
    return {
      'Total Active User': [year],
    };
  }

  // method for Total Orders
  Future<void> ordertotal(BuildContext context) async {
    Map<String, dynamic> body = {
      "domain": "BIZAPP",
      "summary": "total-orders",
    };

    try {
      final res = await http.get(
        Uri.parse(Env.totalorders),
      );

      if (res.statusCode == 200) {
        final resJSON = json.decode(res.body);
        today = resJSON['resultData']['total-orders']['today'] ?? 0;
        ystd = resJSON['resultData']['total-orders']['yesterday'] ?? 0;
        week = resJSON['resultData']['total-orders']['this_week'] ?? 0;
        month = resJSON['resultData']['total-orders']['this_month'] ?? 0;
        year = resJSON['resultData']['total-orders']['this_year'] ?? 0;
      } else {
        print('Error: ${res.statusCode}, Response: ${res.body}');
      }
    } catch (e) {
      print('Error: $e');
    }

    notifyListeners();
  }

  Map<String, List<dynamic>> getDataOR() {
    return {
      'Total Orders': [today, ystd, week, month],
    };
  }

  Map<String, List<dynamic>> getDataYearOR() {
    return {
      'Total Orders': [year],
    };
  }

  // method for Total Subscribers
  Future<void> totalsubscriber(BuildContext context) async {
    Map<String, dynamic> body = {
      "domain": "BIZAPP",
      "summary": "total-subscribers",
    };

    try {
      final res = await http.get(
        Uri.parse(Env.subscribers),
      );

      if (res.statusCode == 200) {
        final resJSON = json.decode(res.body);
        today = resJSON['resultData']['total-subscribers']['BASIC+|today'] ?? 0;
        ystd = resJSON['resultData']['total-subscribers']['BASIC+|yesterday'] ?? 0;
        week = resJSON['resultData']['total-subscribers']['BASIC+|this_week'] ?? 0;
        month = resJSON['resultData']['total-subscribers']['BASIC+|this_month'] ?? 0;
        year = resJSON['resultData']['total-subscribers']['BASIC+|this_year'] ?? 0;

        todayult1 = resJSON['resultData']['total-subscribers']['ULTIMATE1|today'] ?? 0;
        ystdult1 = resJSON['resultData']['total-subscribers']['ULTIMATE1|yesterday'] ?? 0;
        weekult1 = resJSON['resultData']['total-subscribers']['ULTIMATE1|this_week'] ?? 0;
        monthult1 = resJSON['resultData']['total-subscribers']['ULTIMATE1|this_month'] ?? 0;
        yearult1 = resJSON['resultData']['total-subscribers']['ULTIMATE1|this_year'] ?? 0;

        todayult12 = resJSON['resultData']['total-subscribers']['ULTIMATE12|today'] ?? 0;
        ystdult12 = resJSON['resultData']['total-subscribers']['ULTIMATE12|yesterday'] ?? 0;
        weekult12 = resJSON['resultData']['total-subscribers']['ULTIMATE12|this_week'] ?? 0;
        monthult12 = resJSON['resultData']['total-subscribers']['ULTIMATE12|this_month'] ?? 0;
        yearult12 = resJSON['resultData']['total-subscribers']['ULTIMATE12|this_year'] ?? 0;

      } else {
        print('Error: ${res.statusCode}, Response: ${res.body}');
      }
    } catch (e) {
      print('Error: $e');
    }

    notifyListeners();
  }

  Map<String, List<dynamic>> getDataB() {
    return {
      'Total Subscriber BASIC+': [today, ystd, week, month],
    };
  }

  Map<String, List<dynamic>> getDataYearB() {
    return {
      'Total Subscriber BASIC+': [year],
    };
  }

  Map<String, List<dynamic>> getDataULT1() {
    return {
      'Total Subscriber ULTIMATE 1': [todayult1, ystdult1, weekult1, monthult1],
    };
  }

  Map<String, List<dynamic>> getDataYearULT1() {
    return {
      'Total Subscriber ULTIMATE 1': [yearult1],
    };
  }

    Map<String, List<dynamic>> getDataULT12() {
    return {
      'Total Subscriber ULTIMATE 12': [todayult12, ystdult12, weekult12, monthult12],
    };
  }

  Map<String, List<dynamic>> getDataYearULT12() {
    return {
      'Total Subscriber ULTIMATE 12': [yearult12],
    };
  }

  // // method for Total Subscribers
  // Future<void> subSpec(BuildContext context) async {
  //   Map<String, dynamic> body = {
  //     "domain": "BIZAPP",
  //     "summary": "specific-total-subscribers",
  //   };

  //   try {
  //     final res = await http.get(
  //       Uri.parse(Env.totalSubs),
  //     );
  //   }
  // }

  void resetListData() {
    listrekod.clear();
    notifyListeners();
  }

  check(BuildContext context, String username) {
    call = true;
    notifyListeners();
    loginServices(context, userid: username).then((value) {
      call = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      call = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(snackBarBizapp(""));
    });
  }
}
