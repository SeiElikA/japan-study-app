import 'package:dio/dio.dart';
import 'package:japan_study_app/config/utils/api_util.dart';
import 'package:japan_study_app/entity/gallery_entity.dart';
import 'package:japan_study_app/entity/work_entity.dart';

class WorkModel {
  Future<List<WorkEntity>> getWorkData(int dateIndex) async {
    try {
      var response = await DioX.api().get("/work/getWork/$dateIndex");
      if(response.statusCode == 200) {
        var list = response.data as List;
        var result = <WorkEntity>[];
        for(var item in list) {
          result.add(WorkEntity.fromJson(item));
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