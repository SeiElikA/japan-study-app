import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_snackbar.dart';
import 'package:japan_study_app/config/utils/string_util.dart';
import 'package:japan_study_app/entity/experience_entity.dart';
import 'package:japan_study_app/model/experience_model.dart';

class ExperienceController extends GetxController {
  ExperienceModel model = ExperienceModel();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  Rx<List<ExperienceEntity>> experienceList = Rx([]);

  @override
  void onInit() {
    super.onInit();

  }

  Future<void> getStudentData() async {
    try {
      isLoading.value = true;
      isError.value = false;

      experienceList.value = await model.getStudentData();
    } catch(e) {
      isError.value = true;
      errorMsg.value = e.toString().replaceException();
      CustomSnackBar.showCustomErrorSnackBar(title: "錯誤", message: errorMsg.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTeacherData() async {
    try {
      isLoading.value = true;
      isError.value = false;

      experienceList.value = await model.getTeacherData();
    } catch(e) {
      isError.value = true;
      errorMsg.value = e.toString().replaceException();
      CustomSnackBar.showCustomErrorSnackBar(title: "錯誤", message: errorMsg.value);
    } finally {
      isLoading.value = false;
    }
  }
}