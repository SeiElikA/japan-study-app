import 'package:get/get.dart';
import 'package:japan_study_app/app/component/custom_snackbar.dart';
import 'package:japan_study_app/config/utils/string_util.dart';
import 'package:japan_study_app/entity/gallery_entity.dart';
import 'package:japan_study_app/model/gallery_model.dart';

class GalleryController extends GetxController {
  var model = GalleryModel();
  Rx<List<GalleryEntity>> galleryData = Rx([]);
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await getGalleryData();
  }

  Future<void> getGalleryData() async {
    try {
      isLoading.value = true;
      isError.value = false;

      galleryData.value = await model.getGalleryData();
    } catch(e) {
      isError.value = true;
      errorMsg.value = e.toString().replaceException();
      CustomSnackBar.showCustomErrorSnackBar(title: "錯誤", message: errorMsg.value);
    } finally {
      isLoading.value = false;
    }
  }
}