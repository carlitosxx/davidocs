import 'package:davidocs/core/constants/environment.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/dio_interceptor.util.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/models/response_document.model.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';
import 'package:dio/dio.dart';

abstract class IDocumentPendingDataSource {
  DocumentOrFailure getDocumentPending(String documentID);
}

class DocumentPendingDatasourceImpl implements IDocumentPendingDataSource {
  DocumentPendingDatasourceImpl(this.dio);
  final Dio dio;
  @override
  DocumentOrFailure getDocumentPending(String documentID) async {
    try {
      String url = '${Environment.apiUrl}ver_documento_pendiente';
      dio.interceptors.add(DioInterceptor());
      Map<String, dynamic> data = {"codigodocumentopendiente": documentID};
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        final result = ResponseDocumentPendingModel.fromJson(response.data);
        return Either.right(
          result,
        );
      } else if (response.statusCode == 401) {
        return Either.left(
          HttpRequestFailure.unauthorized(),
        );
      } else {
        return Either.left(HttpRequestFailure.notFound());
      }
    } catch (e) {
      return Either.left(
        HttpRequestFailure.server(),
      );
    }
  }
}
