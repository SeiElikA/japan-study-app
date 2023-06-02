import 'package:get/get.dart';
import 'package:japan_study_app/app/controller/daily_controller.dart';
import 'package:japan_study_app/app/controller/gallery_controller.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryController());
  }
}