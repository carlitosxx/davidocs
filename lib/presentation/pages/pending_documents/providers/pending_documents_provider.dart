import 'package:davidocs/core/utils/map_failure_to_string.util.dart';
import 'package:davidocs/data/datasources/remote/document_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/list_documents_pending.datasource.dart';
import 'package:davidocs/data/repositories_impl/documents.repository_impl.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';
import 'package:davidocs/domain/usecases/get_document_pending_by_id.usecase.dart';
import 'package:davidocs/domain/usecases/get_list_documents_pending.usecase.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_document/pending_document_state.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_documents/pending_documents_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'pending_documents/pending_documents_state.dart';

part 'pending_documents/pending_documents_state_notifier.dart';
part 'pending_document/pending_document_state_notifier.dart';

// * respositories Inject
final _repositoryProvider = Provider<IDocumentsRepository>((_) {
  return DocumentsRepositoryImpl(
    iListDocumentsPendingDataSource: ListDocumentsPendingDataSourceImpl(Dio()),
    iDocumentPendingDataSource: DocumentPendingDatasourceImpl(Dio()),
  );
});

// * usecases Inject
/// Provider of use case documents pending
final _useCaseDocumentsPendingProvider = Provider<GetDocumentsPendingUC>((ref) {
  final repository = ref.watch(_repositoryProvider);
  return GetDocumentsPendingUC(repository);
});

/// Provider of use case document pending
final _useCaseDocumentPendingProvider = Provider<GetDocumentPendingByIdUC>(
  (ref) {
    final repository = ref.watch(_repositoryProvider);
    return GetDocumentPendingByIdUC(repository);
  },
);
// * providers
/// Provider of pending documents
final pendingDocumentsNotifierProvider = StateNotifierProvider.autoDispose<
    PendingDocumentsNotifier, PedingDocumentsState>(
  (ref) => PendingDocumentsNotifier(
    getDocumentsPendingUC: ref.watch(_useCaseDocumentsPendingProvider),
  )..getListDocumentsPending(),
);

/// Provider of pending document
final pendingDocumentNotifierProvider =
    StateNotifierProvider<PendingDocumentNotifier, PendingDocumentState>(
        (ref) => PendingDocumentNotifier(
            getDocumentPendingByIdUC:
                ref.watch(_useCaseDocumentPendingProvider)));
