import 'package:dio/dio.dart';
import 'package:japan_study_app/config/api_constants.dart';

const timeout = 10000;

extension DioX on Dio {
  static Dio api() {
    var dio = Dio();
    dio.options.connectTimeout = const Duration(milliseconds: timeout);
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {"content-type": "application/json"};
    return dio;
  }

  static Exception getError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionError:
        return Exception("Connect Timeout");
      case DioErrorType.sendTimeout:
        return Exception("Send Timeout");
      case DioErrorType.receiveTimeout:
        return Exception("Receive Timeout");
      case DioErrorType.badResponse:
        if (e.response != null) {
          var error = e.response!.data["error"];
          if(error != null) {
            return Exception(error.toString());
          } else {
            var error = e.response!.data["message"].toString();
            return Exception(error);
          }
        }
        return Exception(e.response?.statusMessage ?? e.response?.statusCode);
      case DioErrorType.cancel:
        return Exception("User cancel");
      case DioErrorType.unknown:
      default:
        return Exception("Something went wrong");
    }
  }
}