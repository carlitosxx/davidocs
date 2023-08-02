import 'package:davidocs/domain/entities/response_documents_pending.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'pending_documents_state.freezed.dart';

extension PedingDocumentsGetters on PedingDocumentsState {
  bool get isLoading => this is _Loading;
}

@freezed
abstract class PedingDocumentsState with _$PedingDocumentsState {
  /// Data is present state
  const factory PedingDocumentsState.data(
      {required ResponseDocumentsPendingEntity
          responseDocumentsPendingEntity}) = _Data;

  /// Initial/default state
  const factory PedingDocumentsState.initial() = _Initial;

  /// Data is loading state
  const factory PedingDocumentsState.loading() = _Loading;

  /// Error when loading data state
  const factory PedingDocumentsState.error([String? message]) = _Error;
}
