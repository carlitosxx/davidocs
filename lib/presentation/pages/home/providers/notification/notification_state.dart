import 'package:davidocs/domain/entities/response_list_notifications.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  /// Data is present state
  const factory NotificationState.data(
      {required ResponseListNotificationsEntity
          responseListNotificationsEntity}) = _Data;

  /// Initial/default state
  const factory NotificationState.initial() = _Initial;

  /// Data is loading state
  const factory NotificationState.loading() = _Loading;

  /// Error when loading data state
  const factory NotificationState.error([String? message]) = _Error;
}
