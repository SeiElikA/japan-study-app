import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/config/theme/color.dart';

AppBar customAppbar(String title, {
  bool isShowShadow = false,
  bool isBlack = false,
  Widget? textLeading
}) {
  return AppBar(
    title: Row(
      children: [
        if(textLeading != null) ... {
          textLeading,
        },
        const SizedBox(width: 8),
        Text(title, style: TextStyle(fontSize: 24, color: isBlack ? Colors.black : MyColor.whiteColor),),
      ],
    ),
    centerTitle: false,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_rounded,
        color: isBlack ? Colors.black : MyColor.whiteColor,
        shadows: isShowShadow ? [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 3))
        ] : null,
      ),
      splashRadius: 24,
      onPressed: Get.back
    ),
  );
}