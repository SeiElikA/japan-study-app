import 'package:flutter/material.dart';
import 'package:japan_study_app/config/theme/color.dart';

class CustomRectangleIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomRectangleIndicatorPainter(this, onChanged);
  }
}

class _CustomRectangleIndicatorPainter extends BoxPainter {
  final CustomRectangleIndicator decoration;

  _CustomRectangleIndicatorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    const double borderRadius = 999.0;
    const width = 26;
    const height = 4;

    final adjustOffset = Offset(offset.dx + configuration.size!.width / 2 - width / 2, offset.dy + configuration.size!.height);
    final rect = adjustOffset &
        Rect.fromLTRB(
                configuration.size!.width / 2 - (width / 2),
                configuration.size!.height - height,
                configuration.size!.width / 2 + (width / 2),
                configuration.size!.height)
            .size;

    final Paint paint = Paint()
      ..color = MyColor.mainColor
      ..style = PaintingStyle.fill;
    final RRect roundedRect =
        RRect.fromRectAndRadius(rect, const Radius.circular(borderRadius));

    canvas.drawRRect(roundedRect, paint);
  }
}
