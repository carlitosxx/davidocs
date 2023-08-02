import 'package:davidocs/core/constants/environment.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/dio_interceptor.util.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/models/document_pending.model.dart';
import 'package:davidocs/data/models/response_documents_pending.model.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';
import 'package:dio/dio.dart';

abstract class IListDocumentsPendingDataSource {
  DataOrFailure getListDocumentsPending();
}

class ListDocumentsPendingDataSourceImpl
    implements IListDocumentsPendingDataSource {
  final Dio dio;
  ListDocumentsPendingDataSourceImpl(this.dio);
  @override
  DataOrFailure getListDocumentsPending() async {
    try {
      String url = '${Environment.apiUrl}listar_pendientes';

      dio.interceptors.add(DioInterceptor());

      final response = await dio.post(
        url,
      );
      if (response.statusCode == 200) {
        List<DocumentPendingModel> listDocumentsPending = [];
        final lista = response.data['datos'] as Map<String, dynamic>;
        lista.forEach((k, v) =>
            listDocumentsPending.add(DocumentPendingModel.fromJson(v)));
        response.data['datos'] = listDocumentsPending;
        final result = ResponseDocumentsPendingModel.fromJson(response.data);
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
