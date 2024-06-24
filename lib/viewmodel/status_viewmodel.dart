import 'dart:async';
import 'dart:html';
import 'package:bizapptrack/model/listrekodmodel.dart';
import 'package:bizapptrack/utils/constant.dart';
import 'package:bizapptrack/env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatusController extends ChangeNotifier {
  String usernameUser = "";
  String username = ""; // for searching
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

  String today = "";
  String ystd = "";
  String week = "";
  String month = "";
  String year = "";

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

    await http
        .post(Uri.parse(Env.statusShopee), body: body)
        .then((res) async {
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

      resJSON[0]['STATUS'] == "1" ? wsapme = "Connected" : wsapme = "Disconnected";
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

      woo = [resJSON][0]['woowebhook'] == null ? "Tiada" : "";
      resJSON[0]['woowebhook'] != "" ? woo = "Tiada" : woo = "";

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

    today = "";
    ystd = "";
    week = "";
    month = "";
    year = "";

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

  Future<void> ordertotal(BuildContext context) async {
    Map<String, dynamic> body = {
      "domain": "BIZAPP",
      "summary": "total-orders",
    };

    try {
      final res = await http.post(
        Uri.parse(Env.totalorders),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (res.statusCode == 200) {
        final resJSON = json.decode(res.body);
        today = resJSON[0]['today'];
        ystd = resJSON[0]['yesterday'];
        week = resJSON[0]['this_week'];
        month = resJSON[0]['this_month'];
        year = resJSON[0]['this_year'];
      } else {
        print('Error: ${res.statusCode}, Response: ${res.body}');
      }
    } catch (e) {
      print('Error: $e');
    }

    notifyListeners();
  }

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
