import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

void successDilogueBox({required BuildContext context, required String msg}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    text: msg,
    confirmBtnColor: Colors.black,
    backgroundColor: Colors.white,
    headerBackgroundColor: Colors.black,
    // barrierColor: Colors.teal
    // autoCloseDuration: Duration(seconds: 3),
  );
}

void failDilogueBox(
    {required BuildContext context,
    required String msg,
    required String title}) {
  QuickAlert.show(
    title: title,
    context: context,
    type: QuickAlertType.error,
    text: msg,
    confirmBtnColor: Colors.black,
    backgroundColor: Colors.white,
    headerBackgroundColor: Colors.black,
    // autoCloseDuration: Duration(seconds: 3),
  );
}

void confirmDilogueBox(
    {required BuildContext context,
    required String msg,
    required VoidCallback click}) {
  QuickAlert.show(
    title: 'Log Out',
    context: context,
    type: QuickAlertType.confirm,
    text: msg,
    confirmBtnColor: Colors.black,
    backgroundColor: Colors.white,
    headerBackgroundColor: Colors.black,
    // barrierColor: Colors.teal,
    onConfirmBtnTap: click,
    // autoCloseDuration: Duration(seconds: 3),
  );
}

void snackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content), duration: const Duration(seconds: 3)));
}
