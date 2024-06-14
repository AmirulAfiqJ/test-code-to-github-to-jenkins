import 'package:flutter/material.dart';

class StatusController extends ChangeNotifier {
  bool call = false;
  String username = '';
  String roleid = '';
  String nama = '';
  String email = '';

  final List<String> numberOptions = ['Select', 'BualAsia', 'Office HP', 'Personal HP'];
  final List<String> callStatusOptions = ['Select Status', 'Did Not Call', 'Picked Up', 'Ringing', 'Not in service', 'Wrong Number', 'Changed PIC'];
  final List<String> followUpOptions = [
    'Select Follow Up',
    'Irrelevant',
    'Informed Management',
    'WhatsApp',
    'Emailed',
    'WhatsApp & Emailed',
    'Joined 101',
    'Registered A-Z',
    'Subscribed Dedicated Support',
    'Subscribed EjenPro',
    'Upgrade Package'
  ];

  Future<void> loginServices(BuildContext context, {required String userid}) async {
    // Add your login service implementation here
    // Simulating network call with delay
    await Future.delayed(Duration(seconds: 2));
    
    // Mock response
    username = userid;
    roleid = 'Premium';
    nama = 'John Doe';
    email = 'john.doe@example.com';

    notifyListeners();
  }

  void clearSelections({
    required TextEditingController purposeController,
    required TextEditingController feedbackController,
    required TextEditingController reasonController,
    required TextEditingController noteController,
  }) {
    purposeController.clear();
    feedbackController.clear();
    reasonController.clear();
    noteController.clear();

    notifyListeners();
  }
}
