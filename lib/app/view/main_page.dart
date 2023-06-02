import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/blur_status_bar.dart';
import 'package:japan_study_app/app/component/custom_loading_view.dart';
import 'package:japan_study_app/app/component/function_button.dart';
import 'package:japan_study_app/app/component/image_list_item.dart';
import 'package:japan_study_app/app/component/work_best_list_item.dart';
import 'package:japan_study_app/app/controller/main_controller.dart';
import 'package:japan_study_app/app/routes/app_routes.dart';
import 'package:japan_study_app/app/view/download_bottom_sheet.dart';
import 'package:japan_study_app/config/theme/color.dart';
import 'package:shake/shake.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const double functionButtonSpace = 24.0;
  static const double functionButtonPadding = 20.0;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainController controller = Get.put(MainController());

  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      Get.bottomSheet(const DownloadBottomSheet());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            "assets/image/img_background.png",
            fit: BoxFit.cover,
          )),
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MainPage.functionButtonPadding),
                      child: Column(
                        children: [
                          const SizedBox(height: 22),
                          titleBar(),
                          const SizedBox(height: 24),
                          functionBar(),
                          const SizedBox(height: 24),
                          cherryBlossomTitle("精選照片", () {
                            Get.toNamed(Routes.galleryDetailPage, arguments: {
                              "title": "精選照片",
                              "imgList":
                                  controller.mainData.value?.bestImage ?? []
                            });
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    bestPhotoList(),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MainPage.functionButtonPadding),
                      child: Column(
                        children: [
                          cherryBlossomTitle("優良作業", () {
                            Get.toNamed(Routes.bestWorkDetailPage,
                                arguments:
                                    controller.mainData.value?.bestWork ?? []);
                          }),
                          const SizedBox(height: 4),
                          bestWorkList()
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                  height: context.mediaQueryViewPadding.top,
                  child: const BlurStatusBar())),
          Obx(() {
            return Positioned.fill(
                child: Visibility(
                    visible:
                        controller.isLoading.value || controller.isError.value,
                    child: CustomLoadingView(
                      isError: controller.isError.value,
                      errMsg: controller.errorMsg.value,
                      onRetryTap: () async {
                        await controller.getMainData();
                      },
                    )));
          })
        ],
      ),
    );
  }

  Widget functionButton(String title, String iconName, Function() onTap) {
    return SizedBox(
        width: (Get.width -
                (MainPage.functionButtonPadding * 2) -
                MainPage.functionButtonSpace * 3) /
            4,
        child: FunctionButton(
          title: title,
          iconName: iconName,
          onTap: onTap,
        ));
  }

  Widget titleBar() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Text(
                  "新北市 2023",
                  style: TextStyle(color: MyColor.whiteColor, fontSize: 24),
                ),
                const Spacer(),
                Image.asset(
                  "assets/image/img_taiwan.png",
                  height: 24,
                ),
                const SizedBox(width: 4),
                Image.asset(
                  "assets/image/img_japan.png",
                  height: 24,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            child: Text(
              "薦送高中職學生赴日本\n技職研習團",
              style: TextStyle(color: MyColor.whiteColor, fontSize: 32),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: Get.width * 0.13,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: Colors.white.withOpacity(0.89),
            ),
          )
        ],
      ),
    );
  }

  Widget functionBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        functionButton("創意體驗\n技藝增能", "img_brain.png",
            () => Get.toNamed(Routes.dailyItineraryPage)),
        const SizedBox(width: MainPage.functionButtonSpace),
        functionButton("學生心得", "img_student.svg",
            () => Get.toNamed(Routes.studentExperiencePage)),
        const SizedBox(width: MainPage.functionButtonSpace),
        functionButton("師長心得", "img_teacher.svg",
            () => Get.toNamed(Routes.teacherExperiencePage)),
        const SizedBox(width: MainPage.functionButtonSpace),
        functionButton(
            "照片牆", "img_picture.svg", () => Get.toNamed(Routes.galleryPage)),
      ],
    );
  }

  Widget cherryBlossomTitle(String title, Function() onTap) {
    return Row(
      children: [
        Image.asset(
          "assets/image/img_cherry_blossom_white.png",
          width: 24,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(color: MyColor.whiteColor, fontSize: 20),
        ),
        const Spacer(),
        CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onTap,
            child: Text(
              "查看更多",
              style: TextStyle(
                  fontSize: 14,
                  color: MyColor.whiteColor,
                  fontFamily: "GenSenRounded"),
            ))
      ],
    );
  }

  Widget bestPhotoList() {
    return Obx(() {
      return SizedBox(
        height: Get.height * 0.34,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            var url = controller.mainData.value?.bestImage[index] ?? "";
            return ImageListItem(imgUrl: url);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 16);
          },
          itemCount: controller.mainData.value == null ? 0 : 5,
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }

  Widget bestWorkList() {
    return Obx(
      () {
        return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var list = controller.mainData.value?.bestWork ?? [];
              var item = list[index];
              return WorkBestListItem(
                workEntity: item,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12);
            },
            itemCount: controller.mainData.value == null ? 0 : 5);
      },
    );
  }
}
