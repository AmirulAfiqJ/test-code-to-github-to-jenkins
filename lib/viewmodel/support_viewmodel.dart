import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SupportViewModel extends ChangeNotifier {

  String username = "";

  Future getPref(context) async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    username = args["username"];
    notifyListeners();
  }
  final key = new GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController displaySourceController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController displayLevelController = TextEditingController();
  TextEditingController firstResponseController = TextEditingController();
  TextEditingController displayFirstResponseController =
      TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController displayDepartmentController = TextEditingController();
  TextEditingController picController = TextEditingController();
  TextEditingController displayPICController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  void clearAllCheckboxes() {
    for (var checkbox in mediumCheckbox) {
      checkbox.value = false;
    }
    for (var checkbox in productCheckbox) {
      checkbox.value = false;
    }
    for (var checkbox in issueCheckbox) {
      checkbox.value = false;
    }
    for (var checkbox in followUpCheckbox) {
      checkbox.value = false;
    }
  }
  
  List<FormList> sourceList = [
    FormList(name: "", value: ""),
    FormList(name: "Bual.Asia/1800", value: "Bual.Asia/1800"),
    FormList(name: "Facebook", value: "Facebook"),
    FormList(name: "Instagram", value: "Instagram"),
    FormList(name: "TikTok", value: "TikTok"),
    FormList(name: "Youtube", value: "Youtube"),
    FormList(name: "Messenger", value: "Messenger"),
    FormList(name: "Whatsapp Personal", value: "WA (P)"),
    FormList(name: "Whatsapp Office", value: "WA (O)"),
    FormList(name: "Whatsapp C&S", value: "WA C&S"),
    FormList(name: "Email", value: "Email")
  ];

  List<FormList> levelList = [
    FormList(name: "", value: ""),
    FormList(name: "Level 1 (Admin)", value: "1"),
    FormList(name: "Level 2 (Support)", value: "2"),
    FormList(name: "Level 3 (Technical Low)", value: "3"),
    FormList(name: "Level 4 (Technical Medium)", value: "4"),
    FormList(name: "Level 5 (Technical High)", value: "5"),
  ];

  List<FormList> firstResponseList = [
    FormList(name: "Bot", value: "Bot"),
    FormList(name: "Jefrey", value: "Jefrey"),
    FormList(name: "Suhaimi", value: "Suhaimi"),
    FormList(name: "Hasnol", value: "Hasnol"),
    FormList(name: "Mazia", value: "Mazia"),
    FormList(name: "Syahida", value: "Sya"),
    FormList(name: "Asyran", value: "Asyran"),
    FormList(name: "Aidil", value: "Aidil"),
    FormList(name: "Sue", value: "Sue"),
    FormList(name: "Tasnim", value: "Tasnim"),
    FormList(name: "Hamzah", value: "Hamzah"),
  ];

  List<FormList> departmentList = [
    FormList(name: "", value: ""),
    FormList(name: "Admin", value: "Admin"),
    FormList(name: "Growth", value: "Growth"),
    FormList(name: "Support", value: "Support"),
    FormList(name: "Sale", value: "Sale"),
    FormList(name: "Technical", value: "Technical"),
    FormList(name: "Management", value: "Management"),
  ];

  List<FormList> picList = [
    FormList(name: "", value: ""),
    FormList(name: "-", value: "-"),
    FormList(name: "Jefrey", value: "Jefrey"),
    FormList(name: "Suhaimi", value: "Suhaimi"),
    FormList(name: "Hasnol", value: "Hasnol"),
    FormList(name: "Taib", value: "Taib"),
    FormList(name: "Abbas", value: "Abbas"),
    FormList(name: "Amirul", value: "Amirul"),
    FormList(name: "Mazia", value: "Mazia"),
    FormList(name: "Syahida", value: "Sya"),
    FormList(name: "Asyran", value: "Asyran"),
    FormList(name: "Aidil", value: "Aidil"),
    FormList(name: "Sue", value: "Sue"),
    FormList(name: "Tasnim", value: "Tasnim"),
    FormList(name: "Hamzah", value: "Hamzah"),
    FormList(name: "Azhari", value: "Azhari"),
    FormList(name: "Natasha", value: "Natasha"),
  ];

  List<CheckboxItem> mediumCheckbox = [
    CheckboxItem(name: 'Call (Bual.Asia)'),
    CheckboxItem(name: 'Call (Personal)'),
    CheckboxItem(name: 'Call (Office)'),
    CheckboxItem(name: 'Email'),
    CheckboxItem(name: 'Messenger'),
    CheckboxItem(name: 'Comment Section'),
    CheckboxItem(name: 'Whatsapp (Bual.Asia)'),
    CheckboxItem(name: 'Whatsapp (Personal)'),
    CheckboxItem(name: 'Whatsapp (Office)'),
  ];

  List<CheckboxItem> productCheckbox = [
    CheckboxItem(name: 'Bizapp'),
    CheckboxItem(name: 'Bizappay'),
    CheckboxItem(name: 'Bizappos'),
    CheckboxItem(name: 'Bizappage'),
    CheckboxItem(name: 'Bizappshop'),
    CheckboxItem(name: 'Woo Commerce'),
    CheckboxItem(name: 'Third Party'),
    CheckboxItem(name: 'Campaign'),
    CheckboxItem(name: 'Program'),
  ];

  List<CheckboxItem> issueCheckbox = [
    CheckboxItem(name: 'New User'),
    CheckboxItem(name: 'Account'),
    CheckboxItem(name: 'Collaboration'),
    CheckboxItem(name: 'Consultation'),
    CheckboxItem(name: 'Subscription'),
    CheckboxItem(name: 'Support'),
    CheckboxItem(name: 'Integration'),
    CheckboxItem(name: 'Technical'),
    CheckboxItem(name: 'Other')
  ];

  List<CheckboxItem> followUpCheckbox = [
    CheckboxItem(name: 'New Subscription'),
    CheckboxItem(name: 'Growth Program'),
    CheckboxItem(name: 'Upgrade Package'),
    CheckboxItem(name: 'Support Package'),
    CheckboxItem(name: 'Technical Resolve'),
    CheckboxItem(name: 'External Resolve'),
  ];
}

class FormList {
  String name;
  String value;

  FormList({
    required this.name,
    required this.value,
  });
}

class CheckboxItem {
  String name;
  bool value;

  CheckboxItem({required this.name, this.value = false});
}
