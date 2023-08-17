part of '../pending_documents_provider.dart';

class RejectNotifier extends StateNotifier<RejectState> {
  RejectNotifier({
    RejectState? initialState,
    required RejectUC rejectUC,
  })  : _rejectUC = rejectUC,
        super(initialState ?? const RejectState.initial());
  final RejectUC _rejectUC;
  void reset() => state = const RejectState.initial();

  Future<void> rejectDocument(
    String codigodocumentopendiente,
    String motivo,
    String infoequipo,
    String latitud,
    String longitud,
  ) async {
    state = const RejectState.loading();
    final result = await _rejectUC(
      codigodocumentopendiente: codigodocumentopendiente,
      motivo: motivo,
      infoequipo: infoequipo,
      latitud: latitud,
      longitud: longitud,
    );
    result.when(
      left: (error) => state = RejectState.error(
        mapFailureToString(error),
      ),
      right: (rejectEntity) =>
          state = RejectState.data(responseRejectEntity: rejectEntity),
    );
  }
}
