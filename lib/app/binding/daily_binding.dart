import 'package:get/get.dart';
import 'package:japan_study_app/app/controller/daily_controller.dart';

class DailyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyController());
  }
}