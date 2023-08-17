import 'package:davidocs/domain/entities/response_reject.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'reject_state.freezed.dart';

@freezed
abstract class RejectState with _$RejectState {
  /// Data is present state
  const factory RejectState.data(
      {required ResponseRejectEntity responseRejectEntity}) = _Data;

  /// Initial/default state
  const factory RejectState.initial() = _Initial;

  /// Data is loading state
  const factory RejectState.loading() = _Loading;

  /// Error when loading data state
  const factory RejectState.error([String? message]) = _Error;
}
