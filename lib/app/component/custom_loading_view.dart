import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japan_study_app/config/theme/color.dart';

class CustomLoadingView extends StatelessWidget {
  const CustomLoadingView(
      {Key? key,
      required this.isError,
      required this.errMsg,
      required this.onRetryTap})
      : super(key: key);

  final bool isError;
  final String errMsg;
  final Function() onRetryTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.7),
        ),
        Visibility(
          visible: !isError,
          child: Center(
            child: GetPlatform.isIOS
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                  )
                : const CircularProgressIndicator(),
          ),
        ),
        Visibility(
          visible: isError,
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                errMsg,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              CupertinoButton(
                  onPressed: onRetryTap,
                  child: const Text("重試",
                      style:
                          TextStyle(fontSize: 16)))
            ],
          )),
        )
      ],
    );
  }
}
