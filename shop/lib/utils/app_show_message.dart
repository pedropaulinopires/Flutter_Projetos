import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class AppShowMessage{
      static void  showAlert(BuildContext context, CoolAlertType type, String title, String? message) {
      CoolAlert.show(
        title: title,
        context: context,
        type: type,
        backgroundColor: Colors.purple,
        autoCloseDuration: const Duration(seconds: 3),
        showCancelBtn: false
      );
    }
}