import 'package:dio/dio.dart';
import 'package:japan_study_app/config/utils/api_util.dart';
import 'package:japan_study_app/entity/main_data_entity.dart';

class MainModel {
  Future<MainDataEntity> getMainData() async {
    try {
      var response = await DioX.api().get("/main/getMainData");
      if(response.statusCode == 200) {
        return MainDataEntity.fromJson(response.data);
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