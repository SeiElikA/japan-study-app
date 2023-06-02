import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/theme/color.dart';

class DownloadBottomSheet extends StatelessWidget {
  const DownloadBottomSheet({Key? key}) : super(key: key);
  static var iosUrl = "https://apps.apple.com/us/app/日本薦學/id6449745957";
  static var androidUrl =
      "https://play.google.com/store/apps/details?id=com.seielika.japan_study_app";
  static var apiSourceUrl = "https://github.com/SeiElikA/japan-study-app-api";
  static var appSourceUrl = "https://github.com/SeiElikA/japan-study-app";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 7,
          width: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999), color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  color: MyColor.whiteColor),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      children: [childView(isAndroid: true), childView(), githubView()],
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Share.share(
                          "日本薦學\n下載APP，回顧日本薦學時光：\n - iOS: $iosUrl\n - Android: $androidUrl");
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.share,
                          color: MyColor.secondaryColor,
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text("Share",
                              style: TextStyle(
                                  color: MyColor.secondaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "GenSenRounded")),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }

  Widget childView({bool isAndroid = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 12),
          child: Text(
            "${isAndroid ? "Android" : "iOS"} Download",
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: InkWell(
          onTap: () {
            if (isAndroid) {
              launchUrl(Uri.parse(androidUrl),
                  mode: LaunchMode.externalApplication);
            } else {
              launchUrl(Uri.parse(iosUrl),
                  mode: LaunchMode.externalApplication);
            }
          },
          child: Image.asset(
              "assets/image/img_qr_code_${isAndroid ? "android" : "ios"}.png",
              width: Get.width * 0.7),
        ))
      ],
    );
  }

  Widget githubView() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12, bottom: 12),
          child: Text(
            "Open Source",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: Column(
              children: [
                const Spacer(),
                CupertinoButton(
                  onPressed: () {
                    launchUrl(Uri.parse(apiSourceUrl), mode: LaunchMode.externalApplication);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.api, color: MyColor.secondaryColor,),
                      const SizedBox(width: 10),
                      Text("API Source Code", style: TextStyle(color: MyColor.secondaryColor, fontSize: 18),),
                    ],
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  onPressed: () {
                    launchUrl(Uri.parse(appSourceUrl), mode: LaunchMode.externalApplication);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.app_settings_alt, color: MyColor.secondaryColor),
                      const SizedBox(width: 10),
                      Text("APP Source Code", style: TextStyle(color: MyColor.secondaryColor, fontSize: 18)),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ))
      ],
    );
  }
}
