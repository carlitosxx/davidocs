import 'package:davidocs/domain/entities/response_send_pin.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'send_pin_state.freezed.dart';

@freezed
abstract class SendPinState with _$SendPinState {
  /// Data is present state
  const factory SendPinState.data(
      {required ResponseSendPinEntity responseSendPinEntity}) = _Data;

  /// Initial/default state
  const factory SendPinState.initial() = _Initial;

  /// Data is loading state
  const factory SendPinState.loading() = _Loading;

  /// Error when loading data state
  const factory SendPinState.error([String? message]) = _Error;
}
