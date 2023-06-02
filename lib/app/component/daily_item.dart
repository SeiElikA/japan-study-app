import 'package:ellipsis_overflow_text/ellipsis_overflow_text.dart';
import 'package:flutter/material.dart';
import 'package:japan_study_app/config/theme/color.dart';

class DailyItem extends StatelessWidget {
  const DailyItem(
      {Key? key,
      required this.index,
      required this.title,
      required this.content,
      required this.img,
      required this.onTap})
      : super(key: key);

  final int index;
  final String title;
  final String content;
  final String img;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.none,
        child: Container(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.44),
                    offset: const Offset(5, 8),
                    blurRadius: 12)
              ]),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: Stack(
              children: [
                // background image
                Positioned.fill(
                    child: Image.asset(
                  "assets/daily/$img",
                  fit: BoxFit.cover,
                )),

                // bottom introduction
                Positioned(
                    left: 16,
                    right: 16,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // title
                        FittedBox(
                          child: Text(title,
                              style: TextStyle(
                                  color: MyColor.whiteColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 3))
                                  ])),
                        ),
                        const SizedBox(height: 8),

                        // content
                        EllipsisOverflowText(content,
                            maxLines: 4,
                            style: TextStyle(
                                color: MyColor.whiteColor,
                                fontSize: 16,
                                height: 1.1,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 12,
                                      offset: const Offset(0, 3))
                                ]))
                      ],
                    )),

                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColor.whiteColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 3))
                        ]),
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: MyColor.secondaryColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
