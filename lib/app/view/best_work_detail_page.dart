import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_tab_view.dart';
import 'package:japan_study_app/app/component/work_best_list_item.dart';
import 'package:japan_study_app/entity/work_preview_entity.dart';

class BestWorkDetailPage extends StatefulWidget {
  const BestWorkDetailPage({Key? key}) : super(key: key);

  @override
  State<BestWorkDetailPage> createState() => _BestWorkDetailPageState();
}

class _BestWorkDetailPageState extends State<BestWorkDetailPage> {
  List<WorkPreviewEntity> dataList = Get.arguments as List<WorkPreviewEntity>;
  var date = "5/08".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomTabWidget(
            onPageChange: (date) {
              this.date.value = date;
            },
          ),
          Expanded(child: SafeArea(
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "${date.value}作業優良",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),

                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var item = dataList
                              .where((element) =>
                                  element.publishedDate == date.value)
                              .toList()[index];
                          return WorkBestListItem(workEntity: item);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                        itemCount: dataList
                            .where((element) =>
                                element.publishedDate == date.value)
                            .length),
                  ),
                ],
              );
            }),
          ))
        ],
      ),
    );
  }
}
