import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_appbar.dart';
import 'package:japan_study_app/app/component/custom_loading_view.dart';
import 'package:japan_study_app/app/component/custom_snackbar.dart';
import 'package:japan_study_app/app/view/gallery/img_preview_page.dart';
import 'package:japan_study_app/config/utils/img_util.dart';
import 'package:photo_view/photo_view.dart';

class GalleryDetailPage extends StatefulWidget {
  const GalleryDetailPage({Key? key}) : super(key: key);

  @override
  State<GalleryDetailPage> createState() => _GalleryDetailPageState();
}

class _GalleryDetailPageState extends State<GalleryDetailPage> {
  String title = Get.arguments["title"] as String;
  List<String> imgList = Get.arguments["imgList"] as List<String>;
  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title, isBlack: true),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SafeArea(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4),
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                var url = imgList[index];
                return CupertinoContextMenu(
                    actions: [
                      CupertinoContextMenuAction(
                        trailingIcon: CupertinoIcons.cloud_download,
                        onPressed: () {
                          Get.back();
                          isLoading.value = true;
                          ImgUtil.saveImg(url, () {
                            isLoading.value = false;
                          });
                        },
                        child: const Text("Save"),
                      )
                    ],
                    child: Material(
                      child: InkWell(
                        onTap: () {
                            Get.to(() => ImgPreviewPage(url: url));
                          },
                        child: CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.cover,
                          ),
                      ),
                    ));
              },
            ),
          ),
          Obx(() {
            return Positioned.fill(
                child: Visibility(
                    visible: isLoading.value,
                    child: CustomLoadingView(
                      isError: false,
                      errMsg: "",
                      onRetryTap: () {},
                    )));
          })
        ],
      ),
    );
  }
}