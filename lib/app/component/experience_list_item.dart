import 'package:cached_network_image/cached_network_image.dart';
import 'package:ellipsis_overflow_text/ellipsis_overflow_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_appbar.dart';
import 'package:japan_study_app/app/view/gallery/img_preview_page.dart';
import 'package:japan_study_app/config/api_constants.dart';
import 'package:japan_study_app/config/theme/color.dart';
import 'package:photo_view/photo_view.dart';

class ExperienceListItem extends StatelessWidget {
  const ExperienceListItem(
      {Key? key,
      this.authorAvatar,
      required this.authorSchool,
      required this.authorName,
      required this.content,
      this.previewImage,
      required this.docUrl})
      : super(key: key);

  final String? authorAvatar;
  final String authorSchool;
  final String authorName;
  final String content;
  final String? previewImage;
  final String docUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Get.to(
            () => Scaffold(
                appBar: customAppbar(
                  authorName,
                  isBlack: true,
                  textLeading: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: authorAvatar != null ? () {
                      Get.to(() => ImgPreviewPage(
                            url: avatarImgUrl + authorAvatar!,
                            isHideDownload: true,
                          ));
                    } : null,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: authorAvatar == null
                            ? const Icon(
                                CupertinoIcons.person_alt_circle,
                                color: Colors.grey,
                                size: 32,
                              )
                            : CachedNetworkImage(
                                imageUrl: avatarImgUrl + authorAvatar!,
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                              )),
                  ),
                ),
                body: const PDF().cachedFromUrl(docUrl)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: authorAvatar == null
                                ? const Icon(
                                    CupertinoIcons.person_alt_circle,
                                    color: Colors.grey,
                                    size: 32,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: avatarImgUrl + authorAvatar!,
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                  )),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  authorName,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColor.mainTextColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                    color: MyColor.secondaryColor, width: 1.2)),
                            child: Text(
                              authorSchool,
                              style: TextStyle(color: MyColor.secondaryColor),
                            ))
                      ],
                    ),
                    const SizedBox(height: 4),
                    EllipsisOverflowText(
                      content,
                      style: const TextStyle(height: 1.2, color: Colors.black),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),

              Visibility(
                visible: previewImage != null,
                child: const SizedBox(width: 12),
              ),

              // preview image
              Visibility(
                  visible: previewImage != null,
                  child: Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: experienceImgUrl + (previewImage ?? ""),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
