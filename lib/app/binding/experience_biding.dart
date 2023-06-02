import 'package:get/get.dart';
import 'package:japan_study_app/app/controller/experience_controller.dart';

class ExperienceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExperienceController());
  }
}