import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_snackbar.dart';
import 'package:japan_study_app/config/utils/string_util.dart';
import 'package:japan_study_app/entity/main_data_entity.dart';
import 'package:japan_study_app/model/main_model.dart';

class MainController extends GetxController {
  MainModel model = MainModel();
  Rx<MainDataEntity?> mainData = Rx(null);
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getMainData();
  }

  Future<void> getMainData() async {
    try {
      isLoading.value = true;
      isError.value = false;

      mainData.value = await model.getMainData();
    } catch(e) {
      isError.value = true;
      errorMsg.value = e.toString().replaceException();
      CustomSnackBar.showCustomErrorSnackBar(title: "錯誤", message: errorMsg.value);
    } finally {
      isLoading.value = false;
    }
  }
}