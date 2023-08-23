import 'package:davidocs/domain/entities/document_detail.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_detail_state.freezed.dart';

@freezed
abstract class DocumentDetailState with _$DocumentDetailState {
  /// Data is present state
  const factory DocumentDetailState.data(
      {required DocumentDetailEntity documentDetailEntity}) = _Data;

  /// Initial/default state
  const factory DocumentDetailState.initial() = _Initial;

  /// Data is loading state
  const factory DocumentDetailState.loading() = _Loading;

  /// Error when loading data state
  const factory DocumentDetailState.error([String? message]) = _Error;
}
