import 'package:flutter/foundation.dart';

class DrawerState with ChangeNotifier {
  bool _isDrawerOpen = true;

  bool get isDrawerOpen => _isDrawerOpen;

  void toggleDrawer() {
    _isDrawerOpen = !_isDrawerOpen;
    notifyListeners();
  }

  void setDrawerState(bool isOpen) {
    _isDrawerOpen = isOpen;
    notifyListeners();
  }
}
