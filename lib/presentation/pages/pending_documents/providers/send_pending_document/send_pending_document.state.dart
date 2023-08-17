import 'package:davidocs/domain/entities/response_send_document_pending.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'send_pending_document.state.freezed.dart';

extension SendPedingDocumentGetters on SendPedingDocumentState {
  bool get isLoading => this is _Loading;
}

@freezed
abstract class SendPedingDocumentState with _$SendPedingDocumentState {
  /// Data is present state
  const factory SendPedingDocumentState.data(
      {required ResponseSendDocumentPendingEntity
          responseDocumentsPendingEntity}) = _Data;

  /// Initial/default state
  const factory SendPedingDocumentState.initial() = _Initial;

  /// Data is loading state
  const factory SendPedingDocumentState.loading() = _Loading;

  /// Error when loading data state
  const factory SendPedingDocumentState.error([String? message]) = _Error;
}
