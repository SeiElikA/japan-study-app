import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color.dart';

class MyTheme {
  late bool _isDarkMode;

  MyTheme() {
    _isDarkMode = Get.theme.brightness == Brightness.dark;
  }

  Color get iconColor => _isDarkMode ? Colors.white : Colors.black;

  Color get shadowColor =>
      _isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;
}