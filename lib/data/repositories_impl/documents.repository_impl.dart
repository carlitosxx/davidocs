import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/datasources/remote/list_documents_pending.datasource.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class DocumentsRepositoryImpl implements IDocumentsRepository {
  final IListDocumentsPendingDataSource _iListDocumentsPendingDataSource;
  DocumentsRepositoryImpl({
    required IListDocumentsPendingDataSource iListDocumentsPendingDataSource,
  }) : _iListDocumentsPendingDataSource = iListDocumentsPendingDataSource;

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
}
