part of '../injects_provider.dart';

class BusinessNotifier extends StateNotifier<BusinessState> {
  BusinessNotifier({
    BusinessState? initialState,
    required GetListBusinessUC getListBusinessUC,
  })  : _getListBusinessUC = getListBusinessUC,
        super(initialState ?? const BusinessState.initial());
  final GetListBusinessUC _getListBusinessUC;

  void reset() => state = const BusinessState.initial();

  Future<void> getListBusiness() async {
    state = const BusinessState.loading();
    final result = await _getListBusinessUC();

    result.when(
      left: (error) => state = BusinessState.error(mapFailureToString(error)),
      right: (listBusiness) =>
          state = BusinessState.data(responseListBusinessEntity: listBusiness),
    );
  }
}
