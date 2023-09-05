import 'package:freezed_annotation/freezed_annotation.dart';
part 'gps_state.freezed.dart';

@freezed
abstract class GpsState with _$GpsState {
  /// Data is present state
  const factory GpsState.data({required Map<String, dynamic> response}) = _Data;

  /// Initial/default state
  const factory GpsState.initial() = _Initial;

  /// Data is loading state
  const factory GpsState.loading() = _Loading;

  /// Error when loading data state
  const factory GpsState.error([String? message]) = _Error;
}
