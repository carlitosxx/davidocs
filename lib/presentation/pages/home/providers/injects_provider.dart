import 'package:davidocs/core/utils/map_failure_to_string.util.dart';
import 'package:davidocs/data/datasources/remote/document_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/list_documents_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/send_document_pending.datasource.dart';
import 'package:davidocs/data/repositories_impl/documents.repository_impl.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

import 'package:davidocs/domain/usecases/get_list_business.usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'business/business_state.dart';
export 'business/business_state.dart';
part 'business/business_notifier.dart';

// * repositories Inject

final _businessRepositoryProvider = Provider<IDocumentsRepository>(
  (ref) => DocumentsRepositoryImpl(
    iListDocumentsPendingDataSource: ListDocumentsPendingDataSourceImpl(Dio()),
    iDocumentPendingDataSource: DocumentPendingDatasourceImpl(Dio()),
    iSendDocumentPendingDataSource: SendDocumentPendingDataSourceImpl(Dio()),
  ),
);

// * Usecases Injects

final _getListBusinessUCProvider = Provider<GetListBusinessUC>(
  (ref) {
    final repository = ref.watch(_businessRepositoryProvider);
    return GetListBusinessUC(repository);
  },
);

//* Provider
final listBusinessProvider =
    StateNotifierProvider<BusinessNotifier, BusinessState>(
  (ref) => BusinessNotifier(
    getListBusinessUC: ref.watch(_getListBusinessUCProvider),
  )..getListBusiness(),
);
