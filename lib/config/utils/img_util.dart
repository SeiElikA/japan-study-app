import 'package:gallery_saver/gallery_saver.dart';
import 'package:japan_study_app/app/component/custom_snackbar.dart';

class ImgUtil {
  static void saveImg(String url, Function() onSuccess) {
    GallerySaver.saveImage(url).then((bool? success) {
      if (success == true) {
        onSuccess();
        CustomSnackBar.showCustomSnackBar(
            title: "Successful", message: "保存成功");
        return;
      }
      CustomSnackBar.showCustomErrorSnackBar(
          title: "Error", message: "Something Wrong");
    });
  }
}
