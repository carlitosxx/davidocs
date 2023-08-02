part of '../pending_documents_provider.dart';

class PendingDocumentsNotifier extends StateNotifier<PedingDocumentsState> {
  PendingDocumentsNotifier({
    PedingDocumentsState? initialState,
    required GetDocumentsPendingUC getDocumentsPendingUC,
  })  : _getDocumentsPendingUC = getDocumentsPendingUC,
        super(initialState ?? const PedingDocumentsState.initial());
  final GetDocumentsPendingUC _getDocumentsPendingUC;

  void reset() => state = const PedingDocumentsState.initial();
  Future<void> getListDocumentsPending() async {
    state = const PedingDocumentsState.loading();
    final result = await _getDocumentsPendingUC();

    result.when(
        left: (error) => state = PedingDocumentsState.error(
              mapFailureToString(error),
            ),
        right: (responseDocumentsPendingEntity) => state =
            PedingDocumentsState.data(
                responseDocumentsPendingEntity:
                    responseDocumentsPendingEntity));
  }
}
