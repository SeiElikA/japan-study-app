import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FunctionButton extends StatelessWidget {
  const FunctionButton({Key? key, required this.iconName, required this.title, required this.onTap}) : super(key: key);

  final String iconName;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.hardEdge,
            elevation: 12,
            child: InkWell(
              splashColor: Colors.black,
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white.withOpacity(0.7)
                ),
                child: iconName.endsWith("svg") ? SvgPicture.asset("assets/image/$iconName") : Image.asset("assets/image/$iconName"),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        FittedBox(
            child: Text(
          title,
          style: const TextStyle(fontSize: 16, height: 1.2),
        ))
      ],
    );
  }
}
