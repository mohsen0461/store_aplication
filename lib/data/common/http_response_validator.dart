import 'package:dio/dio.dart';
import 'package:store_aplication/common/exception.dart';

mixin HttpResponseValidator {
  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
