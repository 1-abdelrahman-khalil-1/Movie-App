
import 'package:flutter/material.dart';

class PushNavigator {
  static void navigateTo(BuildContext context, Widget page) {
    Navigator.push
      (
      context,MaterialPageRoute(builder: (context) => page)
      );
  }
}