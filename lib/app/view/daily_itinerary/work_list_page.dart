import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_appbar.dart';
import 'package:japan_study_app/app/component/custom_loading_view.dart';
import 'package:japan_study_app/app/controller/work_controller.dart';

class WorkListPage extends StatefulWidget {
  const WorkListPage({Key? key}) : super(key: key);

  @override
  State<WorkListPage> createState() => _WorkListPageState();
}

class _WorkListPageState extends State<WorkListPage> {
  WorkController controller = Get.find();
  int index = Get.arguments as int;

  @override
  void initState() {
    super.initState();
    controller.getWorkData(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("5/${(8 + index).toString().padLeft(2, '0')} 作業",
          isBlack: true),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(child: SafeArea(
            child: Obx(() {
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                itemBuilder: (context, index) {
                  var item = controller.workDataList.value[index];
                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.to(
                        () => Scaffold(
                            appBar: customAppbar(item.name, isBlack: true),
                            body: const PDF().cachedFromUrl(item.url)),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.09),
                                blurRadius: 12,
                                offset: const Offset(0, 12))
                          ]),
                      child: Text(
                        "${item.name.substring(0,2)} ${item.name.substring(2)}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black, fontFamily: "GenSenRounded"),
                      ),
                    ),
                  );
                },
                itemCount: controller.workDataList.value.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: (Get.width - 12 * 3) / 100,
                    crossAxisCount: 2),
              );
            }),
          )),
          Obx(() {
            return Positioned.fill(
                child: Visibility(
                    visible:
                        controller.isLoading.value || controller.isError.value,
                    child: CustomLoadingView(
                      isError: controller.isError.value,
                      errMsg: controller.errorMsg.value,
                      onRetryTap: () async {},
                    )));
          })
        ],
      ),
    );
  }
}
