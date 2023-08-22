import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/datasources/remote/document_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/list_documents_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/send_document_pending.datasource.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class DocumentsRepositoryImpl implements IDocumentsRepository {
  final IListDocumentsPendingDataSource _iListDocumentsPendingDataSource;
  final IDocumentPendingDataSource _iDocumentPendingDataSource;
  final ISendDocumentPendingDataSource _iSendDocumentPendingDataSource;
  DocumentsRepositoryImpl({
    required IListDocumentsPendingDataSource iListDocumentsPendingDataSource,
    required IDocumentPendingDataSource iDocumentPendingDataSource,
    required ISendDocumentPendingDataSource iSendDocumentPendingDataSource,
  })  : _iListDocumentsPendingDataSource = iListDocumentsPendingDataSource,
        _iDocumentPendingDataSource = iDocumentPendingDataSource,
        _iSendDocumentPendingDataSource = iSendDocumentPendingDataSource;

  @override
  DataOrFailure getListDocumentsPending() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return _iListDocumentsPendingDataSource.getListDocumentsPending();
    } else {
      return Either.left(
        HttpRequestFailure.network(),
      );
    }
  }

  @override
  DocumentOrFailure getDocumentPendingById(String documentID) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return _iDocumentPendingDataSource.getDocumentPending(documentID);
    } else {
      return Either.left(
        HttpRequestFailure.network(),
      );
    }
  }

  @override
  SendDocumentPendingOrFailure sendDocumentPending(String documentID) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return _iSendDocumentPendingDataSource.sendDocumentPending(documentID);
    } else {
      return Either.left(
        HttpRequestFailure.network(),
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
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return _iDocumentPendingDataSource.sendPin(codigodocumentopendiente,
          codigotoken, infoequipo, latitud, longitud, pinfirma);
    } else {
      return Either.left(
        HttpRequestFailure.network(),
      );
    }
  }

  @override
  RejectOrFailure rejectDocumentPending(
    String codigodocumentopendiente,
    String motivo,
    String infoequipo,
    String latitud,
    String longitud,
  ) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return _iDocumentPendingDataSource.rejectDocument(
          codigodocumentopendiente, motivo, infoequipo, latitud, longitud);
    } else {
      return Either.left(
        HttpRequestFailure.network(),
      );
    }
  }
}