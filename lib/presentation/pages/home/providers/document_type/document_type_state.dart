import 'package:davidocs/domain/entities/response_list_document_type.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_type_state.freezed.dart';

@freezed
abstract class DocumentTypeState with _$DocumentTypeState {
  /// Data is present state
  const factory DocumentTypeState.data(
      {required ResponseListDocumentTypeEntity
          responseListDocumentTypeEntity}) = _Data;

  /// Initial/default state
  const factory DocumentTypeState.initial() = _Initial;

  /// Data is loading state
  const factory DocumentTypeState.loading() = _Loading;

  /// Error when loading data state
  const factory DocumentTypeState.error([String? message]) = _Error;
}
