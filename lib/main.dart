import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/routes/app_pages.dart';
import 'package:japan_study_app/app/routes/app_routes.dart';
import 'package:japan_study_app/config/theme/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: '日本薦學APP',
        builder: (context, child) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

          return child ?? const SizedBox();
        },
        debugShowCheckedModeBanner: false,
        theme: customTheme(),
        themeMode: ThemeMode.light,
        initialRoute: Routes.mainPage,
        getPages: AppPages.routes,
        defaultTransition: Transition.fadeIn);
  }
}
