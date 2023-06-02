import 'package:dio/dio.dart';
import 'package:japan_study_app/config/utils/api_util.dart';
import 'package:japan_study_app/entity/daily_itinerary_entity.dart';

class DailyModel {
  Future<List<DailyItineraryEntity>> getDailyItinerary() async {
    try {
      var response = await DioX.api().get("/daily/getDailyItinerary");
      if(response.statusCode == 200) {
        var list = response.data as List;
        var result = <DailyItineraryEntity>[];
        for(var item in list) {
          result.add(DailyItineraryEntity.fromJson(item));
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