import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_appbar.dart';
import 'package:japan_study_app/app/component/custom_loading_view.dart';
import 'package:japan_study_app/app/component/experience_list_item.dart';
import 'package:japan_study_app/app/controller/experience_controller.dart';

class TeacherExperiencePage extends StatefulWidget {
  const TeacherExperiencePage({Key? key}) : super(key: key);

  @override
  State<TeacherExperiencePage> createState() => _TeacherExperiencePageState();
}

class _TeacherExperiencePageState extends State<TeacherExperiencePage> {
  final ExperienceController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.getTeacherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: customAppbar("師長心得"),
        body: Stack(children: [
          Positioned.fill(
              child: Image.asset(
                "assets/image/img_background.png",
                fit: BoxFit.cover,
              )),
          Positioned.fill(
              child: SafeArea(
                bottom: false,
                child: Obx(() {
                  return ListView.separated(
                    padding: EdgeInsets.only(
                        left: 14,
                        right: 14,
                        top: 12,
                        bottom: 12 + context.mediaQueryViewPadding.bottom),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.experienceList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = controller.experienceList.value[index];
                      return ExperienceListItem(
                          authorAvatar: item.avatarUrl.isEmpty ? null : item.avatarUrl,
                          authorSchool: item.schoolName,
                          authorName: item.authorName,
                          docUrl: item.docUrl,
                          previewImage: item.imgPreview.isEmpty ? null : item.imgPreview,
                          content: item.shortContent);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 12);
                    },
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
                      onRetryTap: () async {
                        await controller.getTeacherData();
                      },
                    )));
          })
        ]));
  }
}
