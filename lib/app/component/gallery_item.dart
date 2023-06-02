import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/view/gallery/img_preview_page.dart';
import 'package:japan_study_app/config/theme/color.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem(
      {Key? key,
      required this.iconName,
      required this.title,
      required this.onMoreTap,
      required this.previewImage})
      : super(key: key);

  final String iconName;
  final String title;
  final Function() onMoreTap;
  final List<String> previewImage; //from network

  @override
  Widget build(BuildContext context) {
    if (previewImage.isEmpty) {
      return const Text(
        "Your preview image need more then one url string",
        style: TextStyle(color: Colors.red),
      );
    }

    const double imgSpace = 8.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SvgPicture.asset("assets/image/$iconName"),
            const SizedBox(width: 8),
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Spacer(),
            CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: onMoreTap,
                child: Text(
                  "查看更多",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.7), fontFamily: "GenSenRounded"),
                ))
          ],
        ),
        Row(
          children: [
            Expanded(child: imgWithCornerRadius(previewImage[0])),
            const SizedBox(width: imgSpace),
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: imgSpace,
              crossAxisSpacing: imgSpace,
              childAspectRatio: 1,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(4, (index) => index + 1).map((e) {
                if(previewImage.length - 1 < e) {
                  return const SizedBox();
                } else {
                  return imgWithCornerRadius(previewImage[e]);
                }
              }).toList(),
            )),
          ],
        )
      ],
    );
  }

  Widget imgWithCornerRadius(String url) {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: () {
          Get.to(ImgPreviewPage(url: url));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, progress) {
              return Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.withOpacity(0.2)),
              );
            },
          ),
        ),
      ),
    );
  }
}
