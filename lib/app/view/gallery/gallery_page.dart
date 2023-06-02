import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_appbar.dart';
import 'package:japan_study_app/app/component/custom_loading_view.dart';
import 'package:japan_study_app/app/component/gallery_item.dart';
import 'package:japan_study_app/app/controller/gallery_controller.dart';
import 'package:japan_study_app/app/routes/app_routes.dart';

class GalleryPage extends GetView<GalleryController> {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("照片牆", isBlack: true),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: Obx(() {
                  return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = controller.galleryData.value[index];
                        return GalleryItem(iconName: item.iconName,
                            title: item.title,
                            onMoreTap: () {
                              Get.toNamed(Routes.galleryDetailPage, arguments:{
                                "title": item.title,
                                "imgList": item.imgList
                              });
                            },
                            previewImage: item.imgList.sublist(0, (item.imgList
                                .length < 5 ? item.imgList.length : 5)));
                      }, separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  }, itemCount: controller.galleryData.value.length);
                })
            ),
          ),
          Obx(() {
            return Positioned.fill(
                child: Visibility(
                    visible: controller.isLoading.value ||
                        controller.isError.value,
                    child: CustomLoadingView(
                      isError: controller.isError.value,
                      errMsg: controller.errorMsg.value,
                      onRetryTap: () async {
                        await controller.getGalleryData();
                      },
                    )));
          })
        ],
      ),
    );
  }
}
