import 'package:davidocs/core/utils/map_failure_to_string.util.dart';
import 'package:davidocs/data/datasources/remote/document_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/list_documents_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/send_document_pending.datasource.dart';
import 'package:davidocs/data/repositories_impl/documents.repository_impl.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';
import 'package:davidocs/domain/usecases/get_document_detail.usecase.dart';

import 'package:davidocs/domain/usecases/get_list_business.usecase.dart';
import 'package:davidocs/domain/usecases/get_list_documents.usecase.dart';
import 'package:davidocs/domain/usecases/get_list_documents_type.usecase.dart';
import 'package:davidocs/presentation/pages/home/providers/document_detail/document_detail_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'business/business_state.dart';
import 'document_type/document_type_state.dart';
import 'document/document_state.dart';

export 'business/business_state.dart';
export 'document_type/document_type_state.dart';
export 'document/document_state.dart';

part 'business/business_notifier.dart';
part 'document_type/document_type_notifier.dart';
part 'document/document_notifier.dart';
part 'document_detail/document_detail_notifier.dart';
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

final _getListDocumentsTypeUCProvider = Provider<GetListDocumentsTypeUC>(
  (ref) {
    final repository = ref.watch(_businessRepositoryProvider);
    return GetListDocumentsTypeUC(repository);
  },
);

final _getListDocumentsUCProvider = Provider<GetListDocumentsUC>(
  (ref) {
    final repository = ref.watch(_businessRepositoryProvider);
    return GetListDocumentsUC(repository);
  },
);
final _getDocumentDetailUCProvider = Provider<GetDocumentDetailUC>(
  (ref) {
    final repository = ref.watch(_businessRepositoryProvider);
    return GetDocumentDetailUC(repository);
  },
);
//* Provider
final listBusinessProvider =
    StateNotifierProvider<BusinessNotifier, BusinessState>(
  (ref) => BusinessNotifier(
    getListBusinessUC: ref.watch(_getListBusinessUCProvider),
  )..getListBusiness(),
);
final listDocumentsTypeProvider =
    StateNotifierProvider<DocumentTypeNotifier, DocumentTypeState>(
  (ref) => DocumentTypeNotifier(
    getListDocumentsTypeUC: ref.watch(_getListDocumentsTypeUCProvider),
  ),
);

final listDocumentsProvider =
    StateNotifierProvider<DocumentNotifier, DocumentState>(
  (ref) => DocumentNotifier(
    getListDocumentsUC: ref.watch(_getListDocumentsUCProvider),
  ),
);

final documentDetailProvider =
    StateNotifierProvider<DocumentDetailNotifier, DocumentDetailState>(
  (ref) => DocumentDetailNotifier(
    getDocumentDetailUC: ref.watch(_getDocumentDetailUCProvider),
  ),
);
