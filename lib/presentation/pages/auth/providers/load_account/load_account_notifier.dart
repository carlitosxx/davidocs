part of '../get_signin_provider.dart';

class LoadAccountNotifier extends StateNotifier<LoadAccountState> {
  LoadAccountNotifier({
    LoadAccountState? initialState,
    required LoadAccountRemembered loadAccountRememberedUC,
  })  : _loadAccountRememberedUC = loadAccountRememberedUC,
        super(initialState ?? const LoadAccountState.initial());
  final LoadAccountRemembered _loadAccountRememberedUC;

  void reset() => state = const LoadAccountState.initial();

  Future<void> loadAccountRemembered() async {
    state = const LoadAccountState.loading();

    final result = await _loadAccountRememberedUC();

    result.when(
      left: (error) => state = LoadAccountState.error(error),
      right: (response) => state = LoadAccountState.data(response: response),
    );
  }
}
