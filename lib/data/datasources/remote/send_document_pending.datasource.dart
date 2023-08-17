import 'package:davidocs/core/constants/environment.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/dio_interceptor.util.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/models/response_send_document_pending.model.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';
import 'package:dio/dio.dart';

abstract class ISendDocumentPendingDataSource {
  SendDocumentPendingOrFailure sendDocumentPending(String documentID);
}

class SendDocumentPendingDataSourceImpl
    implements ISendDocumentPendingDataSource {
  final Dio dio;
  SendDocumentPendingDataSourceImpl(this.dio);
  @override
  SendDocumentPendingOrFailure sendDocumentPending(String documentID) async {
    try {
      final String url = '${Environment.apiUrl}firmar_pendiente';
      final Map<String, dynamic> body = {
        "codigodocumentopendiente": documentID
      };
      dio.interceptors.add(DioInterceptor());
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        final result = ResponseSendDocumentPendingModel.fromJson(response.data);
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
