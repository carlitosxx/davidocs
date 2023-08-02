import 'package:davidocs/domain/entities/response_document.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'pending_document_state.freezed.dart';

extension PedingDocumentGetters on PendingDocumentState {
  bool get isLoading => this is _Loading;
}

@freezed
abstract class PendingDocumentState with _$PendingDocumentState {
  /// Data is present state
  const factory PendingDocumentState.data(
      {required ResponseDocumentPendingEntity
          responseDocumentPendingEntity}) = _Data;

  /// Initial/default state
  const factory PendingDocumentState.initial() = _Initial;

  /// Data is loading state
  const factory PendingDocumentState.loading() = _Loading;

  /// Error when loading data state
  const factory PendingDocumentState.error([String? message]) = _Error;
}
