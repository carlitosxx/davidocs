import 'package:davidocs/core/utils/map_failure_to_string.util.dart';
import 'package:davidocs/data/datasources/local/gps.datasource.dart';
import 'package:davidocs/data/datasources/remote/document_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/list_documents_pending.datasource.dart';
import 'package:davidocs/data/datasources/remote/send_document_pending.datasource.dart';
import 'package:davidocs/data/repositories_impl/documents.repository_impl.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';
import 'package:davidocs/domain/usecases/get_document_pending_by_id.usecase.dart';
import 'package:davidocs/domain/usecases/get_list_documents_pending.usecase.dart';
import 'package:davidocs/domain/usecases/reject.usecase.dart';
import 'package:davidocs/domain/usecases/send_document_pending.usecase.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_document/pending_document_state.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_documents/pending_documents_state.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/reject/reject_state.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/send_pending_document/send_pending_document.state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'pending_documents/pending_documents_state.dart';

part 'pending_documents/pending_documents_state_notifier.dart';
part 'pending_document/pending_document_state_notifier.dart';
part 'send_pending_document/send_pending_document_state_notifier.dart';
part 'reject/reject_state_notifier.dart';

// * respositories Inject
final _repositoryProvider = Provider<IDocumentsRepository>((_) {
  return DocumentsRepositoryImpl(
    iListDocumentsPendingDataSource: ListDocumentsPendingDataSourceImpl(Dio()),
    iDocumentPendingDataSource: DocumentPendingDatasourceImpl(Dio()),
    iSendDocumentPendingDataSource: SendDocumentPendingDataSourceImpl(Dio()),
    iGpsDataSource: GpsDataSourceImpl(),
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

/// Provider of use case send pending document
final _useCaseSendPendingDocumentProvider = Provider<SendDocumentPendingUC>(
  (ref) {
    final repository = ref.watch(_repositoryProvider);
    return SendDocumentPendingUC(repository);
  },
);

/// Provider of use case reject
final _useCaseRejectProvider = Provider<RejectUC>(
  (ref) {
    final repository = ref.watch(_repositoryProvider);
    return RejectUC(repository);
  },
);

// * providers
/// Provider of pending documents
final pendingDocumentsNotifierProvider =
    StateNotifierProvider<PendingDocumentsNotifier, PedingDocumentsState>(
  (ref) => PendingDocumentsNotifier(
    getDocumentsPendingUC: ref.watch(_useCaseDocumentsPendingProvider),
  )..getListDocumentsPending(),
);

/// Provider of pending document
final pendingDocumentNotifierProvider =
    StateNotifierProvider<PendingDocumentNotifier, PendingDocumentState>(
  (ref) => PendingDocumentNotifier(
    getDocumentPendingByIdUC: ref.watch(_useCaseDocumentPendingProvider),
  ),
);

// Provider of send peding documents
final sendPendingDocumentNotifierProvider =
    StateNotifierProvider<SendPendingDocumentNotifier, SendPedingDocumentState>(
  (ref) => SendPendingDocumentNotifier(
    sendDocumentPendingUC: ref.watch(_useCaseSendPendingDocumentProvider),
  ),
);
final rejectNotifierProvider =
    StateNotifierProvider<RejectNotifier, RejectState>(
  (ref) => RejectNotifier(rejectUC: ref.watch(_useCaseRejectProvider)),
);
