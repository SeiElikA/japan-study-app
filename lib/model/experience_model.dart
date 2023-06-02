import 'package:dio/dio.dart';
import 'package:japan_study_app/config/api_constants.dart';
import 'package:japan_study_app/config/utils/api_util.dart';
import 'package:japan_study_app/entity/experience_entity.dart';

class ExperienceModel {
  Future<List<ExperienceEntity>> getStudentData() async {
    try {
      var response = await DioX.api().get("/experience/getStudent");
      if(response.statusCode == 200) {
        var list = response.data as List;
        var result = <ExperienceEntity>[];
        for(var item in list) {
          var data = ExperienceEntity.fromJson(item);
          data.docUrl = experienceDocUrl + data.docUrl;
          result.add(data);
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

  Future<List<ExperienceEntity>> getTeacherData() async {
    try {
      var response = await DioX.api().get("/experience/getTeacher");
      if(response.statusCode == 200) {
        var list = response.data as List;
        var result = <ExperienceEntity>[];
        for(var item in list) {
          var data = ExperienceEntity.fromJson(item);
          data.docUrl = experienceDocUrl + data.docUrl;
          result.add(data);
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