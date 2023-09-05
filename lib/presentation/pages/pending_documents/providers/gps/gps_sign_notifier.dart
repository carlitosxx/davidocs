part of '../pending_documents_provider.dart';

class GpsSignNotifier extends StateNotifier<GpsState> {
  GpsSignNotifier({
    GpsState? initialState,
    required ValidateGpsUC validateGpsUC,
  })  : _validateGpsUC = validateGpsUC,
        super(initialState ?? const GpsState.initial());
  final ValidateGpsUC _validateGpsUC;
  void reset() => state = const GpsState.initial();

  Future<void> validateGps() async {
    state = const GpsState.loading();
    final result = await _validateGpsUC();
    result.when(
      left: (error) => state = GpsState.error(
        mapFailureToString3(error),
      ),
      right: (response) => state = GpsState.data(response: response),
    );
  }
}
