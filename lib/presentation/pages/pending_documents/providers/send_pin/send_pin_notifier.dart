part of '../pending_documents_provider.dart';

class SendPinNotifier extends StateNotifier<SendPinState> {
  SendPinNotifier({
    SendPinState? initialState,
    required SendPinUC sendPinUC,
  })  : _sendPinUC = sendPinUC,
        super(initialState ?? const SendPinState.initial());
  final SendPinUC _sendPinUC;
  void reset() => state = const SendPinState.initial();

  Future<void> sendPin(
    String codigodocumentopendiente,
    String codigotoken,
    String pinfirma,
    String infoequipo,
    String latitud,
    String longitud,
  ) async {
    state = const SendPinState.loading();
    final result = await _sendPinUC(
      codigodocumentopendiente: codigodocumentopendiente,
      codigotoken: codigotoken,
      pinfirma: pinfirma,
      infoequipo: infoequipo,
      latitud: latitud,
      longitud: longitud,
    );
    result.when(
      left: (error) => state = SendPinState.error(
        mapFailureToString2(error),
      ),
      right: (responseSendPinEntity) => state =
          SendPinState.data(responseSendPinEntity: responseSendPinEntity),
    );
  }
}
