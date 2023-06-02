import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japan_study_app/config/theme/color.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Container(
        width: 78,
        height: 78,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: MyColor.mainColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                  color: Colors.white, offset: Offset(0, 3), blurRadius: 12)
            ]),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: MyColor.mainColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5), offset: const Offset(0, 3), blurRadius: 12)
              ]),
          child: SvgPicture.asset("assets/image/img_arrow_right.svg"),
        ),
      ),
    );
  }
}
