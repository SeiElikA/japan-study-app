import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_snackbar.dart';
import 'package:japan_study_app/config/utils/string_util.dart';
import 'package:japan_study_app/entity/daily_itinerary_entity.dart';
import 'package:japan_study_app/model/daily_model.dart';

class DailyController extends GetxController {
  DailyModel model = DailyModel();
  Rx<List<DailyItineraryEntity>?> dailyEntity = Rx(null);
  int pageLength = 8;
  RxDouble currentPage = 0.0.obs;

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await getDailyItinerary();
  }

  Future<void> getDailyItinerary() async {
    try {
      isLoading.value = true;
      isError.value = false;

      dailyEntity.value = await model.getDailyItinerary();
    } catch(e) {
      isError.value = true;
      errorMsg.value = e.toString().replaceException();
      CustomSnackBar.showCustomErrorSnackBar(title: "錯誤", message: errorMsg.value);
    } finally {
      isLoading.value = false;
    }
  }
}