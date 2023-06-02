import 'package:get/get.dart';
import 'package:japan_study_app/app/controller/work_controller.dart';

class WorkBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WorkController());
  }
}