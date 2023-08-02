import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/datasources/remote/document_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/list_documents_pending.datasource.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class DocumentsRepositoryImpl implements IDocumentsRepository {
  final IListDocumentsPendingDataSource _iListDocumentsPendingDataSource;
  final IDocumentPendingDataSource _iDocumentPendingDataSource;
  DocumentsRepositoryImpl({
    required IListDocumentsPendingDataSource iListDocumentsPendingDataSource,
    required IDocumentPendingDataSource iDocumentPendingDataSource,
  })  : _iListDocumentsPendingDataSource = iListDocumentsPendingDataSource,
        _iDocumentPendingDataSource = iDocumentPendingDataSource;

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
}
