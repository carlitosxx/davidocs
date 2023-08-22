import 'package:davidocs/domain/entities/response_list_business.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_state.freezed.dart';

@freezed
abstract class BusinessState with _$BusinessState {
  /// Data is present state
  const factory BusinessState.data(
      {required ResponseListBusinessEntity responseListBusinessEntity}) = _Data;

  /// Initial/default state
  const factory BusinessState.initial() = _Initial;

  /// Data is loading state
  const factory BusinessState.loading() = _Loading;

  /// Error when loading data state
  const factory BusinessState.error([String? message]) = _Error;
}
