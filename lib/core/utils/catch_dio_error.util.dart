import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/errors/models/bad_request.model.dart';
import 'package:dio/dio.dart';

HttpRequestFailure catchDioError(DioException e) {
  late HttpRequestFailure failure;
  if (e.type == DioExceptionType.badResponse) {
    if (e.response!.statusCode == 400) {
      final badRequestModel = BadRequestModel.fromJson(e.response!.data);
      failure = HttpRequestFailure.badRequest(badRequestModel);
    }
    if (e.response!.statusCode == 404) {
      failure = HttpRequestFailure.notFound();
    } else if (e.response!.statusCode == 401) {
      failure = HttpRequestFailure.unauthorized();
    } else if (e.response!.statusCode! >= 500) {
      failure = HttpRequestFailure.server();
    }
  } else if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    failure = HttpRequestFailure.network();
  } else {
    failure = HttpRequestFailure.local();
  }
  return failure;
}
