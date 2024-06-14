import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SnackBar snackBarBizapp(String error) {
  return SnackBar(
    onVisible: (){
      HapticFeedback.vibrate().timeout(const Duration(milliseconds: 1500));
      HapticFeedback.heavyImpact();
    },
    duration: const Duration(seconds: 4),
    behavior: SnackBarBehavior.floating,
    content: Text("Error. Username not found. Please try again.", style: const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18, color: Colors.white,
    )),
  );
}