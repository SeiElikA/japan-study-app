import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_appbar.dart';
import 'package:japan_study_app/app/component/custom_loading_view.dart';
import 'package:japan_study_app/app/component/daily_item.dart';
import 'package:japan_study_app/app/component/next_button.dart';
import 'package:japan_study_app/app/controller/daily_controller.dart';
import 'package:japan_study_app/app/routes/app_routes.dart';
import 'package:japan_study_app/config/theme/color.dart';
import 'package:japan_study_app/entity/daily_itinerary_entity.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DailyItineraryPage extends StatefulWidget {
  const DailyItineraryPage({Key? key}) : super(key: key);

  @override
  State<DailyItineraryPage> createState() => _DailyItineraryPageState();
}

class _DailyItineraryPageState extends State<DailyItineraryPage> {
  late PageController pageController;
  DailyController controller = Get.find();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.87);
    pageController.addListener(() {
      controller.currentPage.value = pageController.page ?? 0;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar("創意體驗 技藝增能"),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Positioned.fill(
              child: Image.asset(
            "assets/image/img_background.png",
            fit: BoxFit.cover,
          )),
          Positioned.fill(
              child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    // page view
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      height: Get.height * 0.56,
                      width: Get.width,
                      child: Obx(() {
                        return PageView.builder(
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index) {
                            var list = controller.dailyEntity.value ?? [];
                            var item = list[index];
                            return pageViewItem(index, item);
                          },
                          controller: pageController,
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              (controller.dailyEntity.value ?? []).length,
                        );
                      }),
                    ),
                    const Spacer(),

                    // next button
                    Obx(() {
                      return nextButton();
                    }),

                    //  adjust position
                    const Spacer(),
                    const Spacer(),
                  ],
                ),

                // bottom indicator
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(child: indicator()),
                )
              ],
            ),
          )),
          Obx(() {
            return Positioned.fill(
                child: Visibility(
                    visible: controller.isLoading.value || controller.isError.value,
                    child: CustomLoadingView(
                      isError: controller.isError.value,
                      errMsg: controller.errorMsg.value,
                      onRetryTap: () async {
                        await controller.getDailyItinerary();
                      },
                    )));
          })
        ]));
  }

  Widget pageViewItem(int index, DailyItineraryEntity item) {
    return AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double delta = index - controller.currentPage.value;
          double angle = delta * 3;
          double scale = 1 - (delta.abs() * 0.2);

          return Transform.translate(
              offset: Offset(-40 * delta, 0),
              child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // 修復透視問題
                    ..rotateZ(angle * pi / 180) // 繞Z軸旋轉
                    ..scale(scale, scale), // 縮放
                  alignment: Alignment.center,
                  child: DailyItem(
                    index: index,
                    title: item.title,
                    content: item.content,
                    img: 'd${index + 1}.jpg',
                    onTap: () {
                      Get.toNamed(Routes.dailyItineraryDetailPage,
                          arguments: {"index": index, "entity": item});
                    },
                  )));
        });
  }

  Widget indicator() {
    return SmoothPageIndicator(
        controller: pageController,
        count: controller.pageLength,
        effect: ScrollingDotsEffect(
            spacing: 16.0,
            dotWidth: 10.0,
            dotHeight: 10.0,
            activeStrokeWidth: 1.4,
            paintStyle: PaintingStyle.fill,
            fixedCenter: true,
            strokeWidth: 2,
            activeDotScale: 1.6,
            dotColor: MyColor.whiteColor.withOpacity(0.3),
            activeDotColor: MyColor.mainColor),
        onDotClicked: (index) {
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        });
  }

  Widget nextButton() {
    var index = controller.currentPage.value.round();
    var list = (controller.dailyEntity.value ?? []);
    var item = (list.length - 1) < index ? null : list[index];

    if (item == null) {
      return const SizedBox();
    }

    return NextButton(onTap: () {
      Get.toNamed(Routes.dailyItineraryDetailPage,
          arguments: {"index": index, "entity": item});
    });
  }
}
