import 'package:davidocs/domain/entities/response_documents.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_state.freezed.dart';

@freezed
abstract class DocumentState with _$DocumentState {
  /// Data is present state
  const factory DocumentState.data(
          {required ResponseListDocumentsEntity responseListDocumentsEntity}) =
      _Data;

  /// Initial/default state
  const factory DocumentState.initial() = _Initial;

  /// Data is loading state
  const factory DocumentState.loading() = _Loading;

  /// Error when loading data state
  const factory DocumentState.error([String? message]) = _Error;
}
