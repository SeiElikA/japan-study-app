import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_appbar.dart';
import 'package:japan_study_app/app/component/custom_rectangle_indicator.dart';
import 'package:japan_study_app/config/theme/color.dart';
import 'package:japan_study_app/entity/daily_itinerary_entity.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../routes/app_routes.dart';

class DailyItineraryDetailPage extends StatefulWidget {
  const DailyItineraryDetailPage({Key? key}) : super(key: key);

  @override
  State<DailyItineraryDetailPage> createState() =>
      _DailyItineraryDetailPageState();
}

class _DailyItineraryDetailPageState extends State<DailyItineraryDetailPage>
    with SingleTickerProviderStateMixin {
  int index = Get.arguments["index"] as int;
  DailyItineraryEntity entity = Get.arguments["entity"] as DailyItineraryEntity;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("", isShowShadow: true),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          headerImage(),
          Expanded(
              child: Column(
            children: [
              tabBar(),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [introductionPage(), itineraryPage()]),
              )
            ],
          )),
          workLinkButton()
        ],
      ),
    );
  }

  Widget headerImage() {
    return Hero(
      tag: index,
      child: Stack(
        children: [
          Material(
            elevation: 12,
            clipBehavior: Clip.antiAlias,
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(42)),
            child: Image.asset(
              "assets/daily/d${index + 1}.jpg",
              height: Get.height * 0.34,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 24,
            left: 26,
            // constraint text size
            child: Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.8),
              child: Material(
                color: Colors.transparent,
                child: FittedBox(
                  child: Text(
                    entity.title,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: MyColor.whiteColor,
                        shadows: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 3))
                        ]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget workLinkButton() {
    return Container(
      padding: EdgeInsets.only(
          top: 12,
          left: 20,
          right: 20,
          bottom: context.mediaQueryViewPadding.bottom + 12),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(18)),
          color: MyColor.whiteColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.24),
                offset: const Offset(0, -3),
                blurRadius: 12)
          ]),
      child: Row(
        children: [
          SvgPicture.asset("assets/image/img_book.svg", height: 18),
          const SizedBox(width: 8),
          const Text(
            "本日作業",
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: MyColor.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  shadowColor: Colors.black.withOpacity(0.6),
                  elevation: 6,
                  padding: const EdgeInsets.symmetric(horizontal: 14)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "前往查看",
                    style: TextStyle(color: MyColor.mainTextColor),
                  ),
                  const SizedBox(width: 12),
                  SvgPicture.asset("assets/image/img_sort_arrow_right.svg",
                      color: MyColor.mainTextColor)
                ],
              ),
              onPressed: () {
                Get.toNamed(Routes.workListPage, arguments: index);
              })
        ],
      ),
    );
  }

  Widget tabBar() {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(top: 2),
      child: TabBar(
          controller: tabController,
          enableFeedback: true,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          splashBorderRadius: BorderRadius.circular(999),
          indicator: CustomRectangleIndicator(),
          labelStyle: const TextStyle(fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black.withOpacity(0.5),
          tabs: const [
            Tab(
              text: "簡介",
            ),
            Tab(
              text: "行程",
            ),
          ]),
    );
  }

  Widget introductionPage() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Text(
          entity.content,
          style: TextStyle(
              color: MyColor.dailyContentTextColor,
              fontSize: 18,
              height: 1.3,
              letterSpacing: 0.5),
        ),
      ),
    );
  }

  Widget itineraryPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Timeline.tileBuilder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        theme: TimelineThemeData(
          nodePosition: 0,
          indicatorTheme: const IndicatorThemeData(
            position: 0,
            size: 20.0,
          ),
          connectorTheme: const ConnectorThemeData(
            thickness: 2.5,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemCount: entity.itinerary.length,
          contentsBuilder: (context, index) {
            var item = entity.itinerary[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: (item.dateTime ?? "").isNotEmpty,
                    child: Column(
                      children: [
                        Text(item.dateTime?.trim().replaceAll("-", "~") ?? "",
                            style: TextStyle(
                                height: 1.3,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  Linkify(
                    onOpen: (link) async {
                      print(link.url);
                      var url = Uri.parse(link.url);
                      try {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      } catch(e) {
                        print(e);
                      }
                    },
                    text: item.introduction ?? "",
                    style: const TextStyle(
                        height: 1.3, fontSize: 16),
                    linkStyle: TextStyle(
                      color: MyColor.secondaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            );
          },
          indicatorBuilder: (context, index) {
            return OutlinedDotIndicator(
              borderWidth: 3,
              color: MyColor.mainColor,
            );
          },
          connectorBuilder: (context, index, type) {
            return SolidLineConnector(
              color: MyColor.mainColor,
              thickness: 3,
            );
          },
        ),
      ),
    );
  }
}
