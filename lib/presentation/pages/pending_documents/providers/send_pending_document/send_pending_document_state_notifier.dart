part of '../pending_documents_provider.dart';

class SendPendingDocumentNotifier
    extends StateNotifier<SendPedingDocumentState> {
  SendPendingDocumentNotifier({
    SendPedingDocumentState? initialState,
    required SendDocumentPendingUC sendDocumentPendingUC,
  })  : _sendDocumentPendingUC = sendDocumentPendingUC,
        super(initialState ?? const SendPedingDocumentState.initial());
  final SendDocumentPendingUC _sendDocumentPendingUC;
  void reset() => state = const SendPedingDocumentState.initial();

  Future<void> sendDocumentPending(String documentID) async {
    state = const SendPedingDocumentState.loading();
    final result = await _sendDocumentPendingUC(documentID: documentID);

    result.when(
        left: (error) => state = SendPedingDocumentState.error(
              mapFailureToString(error),
            ),
        right: (responseDocumentsPendingEntity) => state =
            SendPedingDocumentState.data(
                responseDocumentsPendingEntity:
                    responseDocumentsPendingEntity));
  }
}
