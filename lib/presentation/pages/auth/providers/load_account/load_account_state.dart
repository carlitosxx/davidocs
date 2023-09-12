import 'package:freezed_annotation/freezed_annotation.dart';

part 'load_account_state.freezed.dart';

@freezed
abstract class LoadAccountState with _$LoadAccountState {
  /// Data is present state
  const factory LoadAccountState.data({required Map<String, String> response}) =
      _Data;

  /// Initial/default state
  const factory LoadAccountState.initial() = _Initial;

  /// Data is loading state
  const factory LoadAccountState.loading() = _Loading;

  /// Error when loading data state
  const factory LoadAccountState.error([String? message]) = _Error;
}
