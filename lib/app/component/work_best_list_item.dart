import 'package:cached_network_image/cached_network_image.dart';
import 'package:ellipsis_overflow_text/ellipsis_overflow_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_appbar.dart';
import 'package:japan_study_app/config/api_constants.dart';
import 'package:japan_study_app/config/theme/color.dart';
import 'package:japan_study_app/entity/work_preview_entity.dart';

class WorkBestListItem extends StatelessWidget {
  const WorkBestListItem({Key? key, required this.workEntity})
      : super(key: key);

  final WorkPreviewEntity workEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => Scaffold(
              appBar: customAppbar("${workEntity.authorName}-${workEntity.publishedDate}作業", isBlack: true),
              body: const PDF().cachedFromUrl(workEntity.docUrl)),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: workEntity.previewImg.isEmpty ? textWidget() : hasImageWidget(),
      ),
    );
  }

  Widget hasImageWidget() {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 12, left: 12),
        decoration: BoxDecoration(
            color: MyColor.whiteColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 12,
              )
            ]),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              // name + content
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, right: 4, left: 90 - 12 + 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workEntity.authorName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    EllipsisOverflowText(
                      workEntity.content,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.2,
                        color: MyColor.contentTextColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),

              // datetime
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                  child: Text(
                    "2023.${workEntity.publishedDate.split("/")[0].padLeft(2, '0')}.${workEntity.publishedDate.split("/")[1]}",
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.23),
                      blurRadius: 12,
                    )
                  ]),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: "$workPreviewImgUrl${workEntity.previewImg}",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget textWidget() {
    return Container(
      decoration: BoxDecoration(
          color: MyColor.whiteColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 12,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workEntity.authorName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            EllipsisOverflowText(
              workEntity.content,
              maxLines: 4,
              style: TextStyle(
                fontSize: 14,
                height: 1.2,
                color: MyColor.contentTextColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "2023.${workEntity.publishedDate.split("/")[0].padLeft(2, '0')}.${workEntity.publishedDate.split("/")[1]}",
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
