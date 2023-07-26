part of 'get_signin_provider.dart';

class SigninNotifier extends StateNotifier<SigninState> {
  SigninNotifier({
    SigninState? initialState,
    required GetSigninUC getSigningUC,
  })  : _getSigningUC = getSigningUC,
        super(initialState ?? const SigninState.initial());
  final GetSigninUC _getSigningUC;

  void reset() => state = const SigninState.initial();

  Future<void> getSignin(String user, String password) async {
    state = const SigninState.loading();

    final result = await _getSigningUC(user: user, password: password);

    result.when(
      left: (error) => state = SigninState.error(mapFailureToString(error)),
      right: (responseSigningEntity) =>
          state = SigninState.data(responseSigninEntity: responseSigningEntity),
    );
  }
}
