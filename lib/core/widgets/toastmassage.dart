import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class toastMassage {
  static void show({required String massege, bool isError = true}) {
    Fluttertoast.showToast(
      msg: massege,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError
          ? Color.fromARGB(255, 204, 7, 7)
          : Color.fromARGB(255, 5, 200, 8),
      textColor: Color.fromARGB(255, 255, 255, 255),
      fontSize: 16,
    );
  }
}
