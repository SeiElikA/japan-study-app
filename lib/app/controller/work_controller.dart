import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_snackbar.dart';
import 'package:japan_study_app/config/utils/string_util.dart';
import 'package:japan_study_app/entity/work_entity.dart';
import 'package:japan_study_app/model/work_model.dart';

class WorkController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  var model = WorkModel();
  Rx<List<WorkEntity>> workDataList = Rx([]);

  Future<void> getWorkData(int index) async {
    try {
      isLoading.value = true;
      isError.value = false;

      workDataList.value = await model.getWorkData(index);
    } catch(e) {
      isError.value = true;
      errorMsg.value = e.toString().replaceException();
      CustomSnackBar.showCustomErrorSnackBar(title: "錯誤", message: errorMsg.value);
    } finally {
      isLoading.value = false;
    }
  }
}