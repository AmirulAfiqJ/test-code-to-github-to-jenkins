import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizapptrack/viewmodel/status_viewmodel.dart';

class NewCustomerViewModel extends ChangeNotifier {
  String username = "";
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future getRoute(context) async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    username = args["username"];
    notifyListeners();
  }
  
  // Dropdown items
  final List<String> numberItems = ['Select', 'BualAsia', 'Office HP', 'Personal HP'];
  final List<String> callStatusItems = ['Select Status', 'Did Not Call', 'Picked Up', 'Ringing', 'Not in service', 'Wrong Number', 'Changed PIC'];
  final List<String> feedbackItems = [
    'Select Feedback', 'New User', 'Renewal', 'New, need help', 'Current, need help', 'New, want to learn', 'Current, want to learn',
    'New, Request upgrade', 'Current, Request upgrade', 'New, Request consultation', 'Current, Request consultation', 'New, Request support',
    'Current, Request support', 'New, Request refund', 'Current, Request refund'
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
  bool _isUpdated = false;
  bool isLoading = false;

  String get selectedNumber => _selectedNumber;
  String get selectedCallStatus => _selectedCallStatus;
  String get selectedFeedback => _selectedFeedback;
  String get selectedAction => _selectedAction;
  String get selectedFollowUp => _selectedFollowUp;
  String get noteText => _noteText;
  bool get isUpdated => _isUpdated;

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

  void setIsUpdated(bool value) {
    _isUpdated = value;
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
    }
  }

  void clearSelections() {
    _selectedNumber = 'Select';
   

  void getPref(BuildContext context) {} _selectedCallStatus = 'Select Status';
    _selectedFeedback = 'Select Feedback';
    _selectedAction = 'Select Action';
    _selectedFollowUp = 'Select Follow Up';
    noteController.clear();
    _noteText = '';
    _isUpdated = false;
    notifyListeners();
  }
}
