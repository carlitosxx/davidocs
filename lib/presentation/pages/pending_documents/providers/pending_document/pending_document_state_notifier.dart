part of '../pending_documents_provider.dart';

class PendingDocumentNotifier extends StateNotifier<PendingDocumentState> {
  PendingDocumentNotifier({
    PendingDocumentState? initialState,
    required GetDocumentPendingByIdUC getDocumentPendingByIdUC,
  })  : _getDocumentPendingByIdUC = getDocumentPendingByIdUC,
        super(initialState ?? const PendingDocumentState.initial());
  final GetDocumentPendingByIdUC _getDocumentPendingByIdUC;
  void reset() => state = const PendingDocumentState.initial();
  Future<void> getDocumentPendingByID(String documentID) async {
    state = const PendingDocumentState.loading();
    final result = await _getDocumentPendingByIdUC(documentID: documentID);

    result.when(
        left: (error) => state = PendingDocumentState.error(
              mapFailureToString(error),
            ),
        right: (responseDocumentPendingEntity) => state =
            PendingDocumentState.data(
                responseDocumentPendingEntity: responseDocumentPendingEntity));
  }
}
