// new_customer_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';

class InactiveViewmodel extends ChangeNotifier {

  String username = "";

  Future getPref(context) async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    username = args["username"];
    notifyListeners();
  }
  
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  // Dropdown items
  final List<String> numberItems = ['Select', 'BualAsia', 'Office HP', 'Personal HP'];
  final List<String> callStatusItems = ['Select Status', 'Did Not Call', 'Picked Up', 'Ringing', 'Not in service', 'Wrong Number', 'Changed PIC'];
  final List<String> feedbackItems = [
    'Select Feedback','Do not know how to use','Use Shopee only','Use TikTok only','Use Website only','Use Shopee & TikTok',
    'Stop Business','Stop using BIZAPP','Business Break Momentarily','Change Business Model','Return to manual',
    'Use another BIZAPP ID','Business slow, still using','Seasonal, will use later'
  ];
  final List<String> actionItems = [
    'Select Action', 'Not priority to call', 'Call, to follow up', 'Offer Demo', 'Offer Bizapp 101', 'Offer Bizapp A-Z', 'Offer Dedicated Support',
    'Offer EjenPro', 'Offer Upgrade', 'To Management'
  ];
  final List<String> followUpItems = [
    'Select Follow Up', 'Irrelevent', 'Informed Management', 'WhatsApp', 'Emailed', 'WhatsApp & Emailed', 'Joined 101', 'Registered A-Z',
    'Subscribed Dedicated Support', 'Subscribed EjenPro', 'Upgrade Package'
  ];
  
  // Selected values
  String _selectedNumber = 'Select';
  String _selectedCallStatus = 'Select Status';
  String _selectedFeedback = 'Select Feedback';
  String _selectedAction = 'Select Action';
  String _selectedFollowUp = 'Select Follow Up';
  String _noteText = '';
  bool isLoading = false;

  String get selectedNumber => _selectedNumber;
  String get selectedCallStatus => _selectedCallStatus;
  String get selectedFeedback => _selectedFeedback;
  String get selectedAction => _selectedAction;
  String get selectedFollowUp => _selectedFollowUp;
  String get noteText => _noteText;

  void setSelectedNumber(String value) {
    _selectedNumber = value;
    notifyListeners();
  }

  void setSelectedCallStatus(String value) {
    _selectedCallStatus = value;
    notifyListeners();
  }

  void setSelectedFeedback(String value) {
    _selectedFeedback = value;
    notifyListeners();
  }

  void setSelectedAction(String value) {
    _selectedAction = value;
    notifyListeners();
  }

  void setSelectedFollowUp(String value) {
    _selectedFollowUp = value;
    notifyListeners();
  }

  void setNoteText(String value) {
    _noteText = value;
    notifyListeners();
  }

  void performSearch(BuildContext context) async {
    final model = Provider.of<StatusController>(context, listen: false);
    isLoading = true;
    notifyListeners();
    try {
      await model.loginServices(context, userid: usernameController.text);
      await model.profile(context, pid: model.pid);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearSelections() {
    _selectedNumber = 'Select';
    _selectedCallStatus = 'Select Status';
    _selectedFeedback = 'Select Feedback';
    _selectedAction = 'Select Action';
    _selectedFollowUp = 'Select Follow Up';
    noteController.clear();
    notifyListeners();
  }
}
