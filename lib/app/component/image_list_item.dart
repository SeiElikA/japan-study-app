import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/view/gallery/img_preview_page.dart';
import 'package:japan_study_app/config/theme/color.dart';

class ImageListItem extends StatelessWidget {
  const ImageListItem({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: InkWell(
        onTap: () {
          Get.to(() => ImgPreviewPage(url: imgUrl));
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MyColor.secondaryColor, width: 0.1),
              boxShadow: [
                BoxShadow(
                    color: MyColor.whiteColor.withOpacity(0.36),
                    blurRadius: 6,
                    offset: const Offset(0, 3))
              ]),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            placeholder: (context, progress) {
              return GetPlatform.isIOS
                  ? const CupertinoActivityIndicator()
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
