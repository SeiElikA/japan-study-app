import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_loading_view.dart';
import 'package:japan_study_app/config/utils/img_util.dart';
import 'package:photo_view/photo_view.dart';

class ImgPreviewPage extends StatefulWidget {
  const ImgPreviewPage(
      {Key? key, required this.url, this.isHideDownload = false})
      : super(key: key);

  final String url;
  final bool isHideDownload;

  @override
  State<ImgPreviewPage> createState() => _ImgPreviewPageState();
}

class _ImgPreviewPageState extends State<ImgPreviewPage> {
  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: widget.isHideDownload ? [] : [
          IconButton(
              onPressed: () {
                isLoading.value = true;
                ImgUtil.saveImg(widget.url, () {
                  isLoading.value = false;
                });
              },
              splashRadius: 24,
              icon: const Icon(CupertinoIcons.cloud_download))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(
              child: PhotoView(
            minScale: 0.16,
            maxScale: 2.0,
            imageProvider: NetworkImage(widget.url),
          )),
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
