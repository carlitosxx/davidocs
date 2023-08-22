import 'package:davidocs/core/constants/environment.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/errors/models/bad_request.model.dart';
import 'package:davidocs/core/utils/dio_interceptor.util.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/models/response_document.model.dart';
import 'package:davidocs/data/models/response_list_business.model.dart';
import 'package:davidocs/data/models/response_reject.model.dart';
import 'package:davidocs/data/models/response_send_pin.model.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';
import 'package:dio/dio.dart';

abstract class IDocumentPendingDataSource {
  DocumentOrFailure getDocumentPending(String documentID);
  SendPinorFailure sendPin(
    String codigodocumentopendiente,
    String codigotoken,
    String pinfirma,
    String infoequipo,
    String latitud,
    String longitud,
  );
  RejectOrFailure rejectDocument(
    String codigodocumentopendiente,
    String motivo,
    String infoequipo,
    String latitud,
    String longitud,
  );
  ListBusinessOrFailure getListBusiness();
}

class DocumentPendingDatasourceImpl implements IDocumentPendingDataSource {
  DocumentPendingDatasourceImpl(this.dio);
  final Dio dio;
  @override
  DocumentOrFailure getDocumentPending(String documentID) async {
    try {
      String url = '${Environment.apiUrl}ver_documento_pendiente';
      dio.interceptors.add(DioInterceptor());
      final Map<String, dynamic> data = {
        "codigodocumentopendiente": documentID
      };
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

  @override
  SendPinorFailure sendPin(
      String codigodocumentopendiente,
      String codigotoken,
      String pinfirma,
      String infoequipo,
      String latitud,
      String longitud) async {
    try {
      String url = '${Environment.apiUrl}ver_documento_pendiente';
      dio.interceptors.add(DioInterceptor());
      final Map<String, dynamic> data = {
        'codigodocumentopendiente': codigodocumentopendiente,
        'codigotoken': codigotoken,
        'pinfirma': pinfirma,
        'infoequipo': infoequipo,
        'latitud': latitud,
        'longitud': longitud,
      };
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        // final result = ResponseSendPinModel.fromJson(response.data);
        final result = ResponseSendPinModel();
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

  @override
  RejectOrFailure rejectDocument(String codigodocumentopendiente, String motivo,
      String infoequipo, String latitud, String longitud) async {
    try {
      String url = '${Environment.apiUrl}rechazar_documento';
      dio.interceptors.add(DioInterceptor());
      final Map<String, dynamic> data = {
        'codigodocumentopendiente': codigodocumentopendiente,
        'motivo': motivo,
        'infoequipo': infoequipo,
        'latitud': latitud,
        'longitud': longitud,
      };
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        if (response.data['error'] == false) {
          final login = ResponseRejectModel.fromJson(response.data);
          print(login.notificacion);
          return Either.right(
            login,
          );
        } else {
          final badRequestModel = BadRequestModel.fromJson(response.data);
          return Either.left(
            HttpRequestFailure.badRequest(badRequestModel),
          );
        }
      } else if (response.statusCode == 401) {
        return Either.left(
          HttpRequestFailure.unauthorized(),
        );
      } else {
        return Either.left(
          HttpRequestFailure.notFound(),
        );
      }
    } catch (e) {
      return Either.left(
        HttpRequestFailure.local(),
      );
    }
  }

  @override
  ListBusinessOrFailure getListBusiness() async {
    try {
      String url = '${Environment.apiUrl}listar_empresas';

      dio.interceptors.add(DioInterceptor());

      final response = await dio.post(
        url,
      );
      if (response.statusCode == 200) {
        List<BusinessModel> listBusiness = [];
        final lista = response.data['datos'] as Map<String, dynamic>;
        lista.forEach((k, v) => listBusiness.add(BusinessModel.fromJson(v)));
        response.data['datos'] = listBusiness;
        final result = ResponseListBusinessmodel.fromJson(response.data);
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
      print(e);
      return Either.left(
        HttpRequestFailure.server(),
      );
    }
  }
}
