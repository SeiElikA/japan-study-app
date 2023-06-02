import 'package:dio/dio.dart';
import 'package:japan_study_app/config/utils/api_util.dart';
import 'package:japan_study_app/entity/gallery_entity.dart';

class GalleryModel {
  Future<List<GalleryEntity>> getGalleryData() async {
    try {
      var response = await DioX.api().get("/gallery/getGalleryData");
      if(response.statusCode == 200) {
        var list = response.data as List;
        var result = <GalleryEntity>[];
        for(var item in list) {
          result.add(GalleryEntity.fromJson(item));
        }
        return result;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioError catch(e) {
      print(e);
      throw DioX.getError(e);
    } catch(e) {
      print(e);
      rethrow;
    }
  }
}