import 'package:davidocs/domain/entities/response_signin.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_signin_state.freezed.dart';

extension SigninGetters on SigninState {
  bool get isLoading => this is _Loading;
}

@freezed
abstract class SigninState with _$SigninState {
  /// Data is present state
  const factory SigninState.data(
      {required ResponseSigninEntity responseSigninEntity}) = _Data;

  /// Initial/default state
  const factory SigninState.initial() = _Initial;

  /// Data is loading state
  const factory SigninState.loading() = _Loading;

  /// Error when loading data state
  const factory SigninState.error([String? message]) = _Error;
}
