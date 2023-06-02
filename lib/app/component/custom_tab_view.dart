
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_check_pointer.dart';
import 'package:japan_study_app/app/component/vertical_text.dart';

import '../../config/theme/color.dart';

class CustomTabWidget extends StatefulWidget {
  const CustomTabWidget({Key? key, required this.onPageChange}) : super(key: key);

  final Function(String) onPageChange;

  @override
  State<CustomTabWidget> createState() => _CustomTabWidgetState();
}

class _CustomTabWidgetState extends State<CustomTabWidget>
    with TickerProviderStateMixin {
  final List<String> _dateList = [
    "5 / 08",
    "5 / 09",
    "5 / 10",
    "5 / 11",
    "5 / 12",
    "5 / 13",
    "5 / 14",
    "5 / 15"
  ];
  final List<GlobalKey> _keys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  RxInt checkIndex = 0.obs;
  Rx<Offset> animationOffset = Rx(const Offset(0, 0));
  Offset checkedPositionOffset = const Offset(0, 0);
  Offset lastCheckOffset = const Offset(0, 0);
  late Animation _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    addAnimation();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      calculateCheckOffset();
      addAnimation();
    });
  }

  void calculateCheckOffset() {
    lastCheckOffset = checkedPositionOffset;
    RenderBox? renderBox =
    _keys[checkIndex.value].currentContext?.findRenderObject() as RenderBox;
    Offset widgetOffset =
        renderBox?.localToGlobal(const Offset(0, 0)) ?? const Offset(0, 0);
    Size widgetSize = renderBox.size;
    checkedPositionOffset = Offset(widgetOffset.dx + widgetSize.width,
        widgetOffset.dy + widgetSize.height / 4 * 3);
  }

  void addAnimation() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: lastCheckOffset.dy, end: checkedPositionOffset.dy)
        .animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack));

    _animationController.addListener(() {
      animationOffset.value =
          Offset(checkedPositionOffset.dx, _animation.value);
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: 64,
            height: Get.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: MyColor.mainColor,
                borderRadius: BorderRadius.circular(30)),
            child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: Get.back,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        splashRadius: 24,
                      ),
                      Expanded(
                        child: Column(
                            children: _dateList
                                .map((e) => Expanded(
                              child: CupertinoButton(
                                onPressed: () {
                                  indexChecked(_dateList.indexOf(e));
                                },
                                child: Obx(() {
                                  return VerticalText(e,
                                      key: _keys[_dateList.indexOf(e)],
                                      isSelect: checkIndex.value ==
                                          _dateList.indexOf(e));
                                }),
                              ),
                            ))
                                .toList()),
                      ),
                    ],
                  ),
                ))),
        Obx(() {
          return Positioned(
              top: animationOffset.value.dy,
              left: animationOffset.value.dx,
              child:
              CustomPaint(painter: CheckPointPainter(const Offset(12, 0))));
        })
      ],
    );
  }

  void indexChecked(int i) {
    if (checkIndex.value == i) return;
    checkIndex.value = i;
    setState(() {
      calculateCheckOffset();
      addAnimation();
    });

    widget.onPageChange(_dateList[i].replaceAll(" ", ""));
  }
}
