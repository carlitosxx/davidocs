part of '../injects_provider.dart';

class NotificationNotifier extends StateNotifier<NotificationState> {
  NotificationNotifier({
    NotificationState? initialState,
    required GetListNotificationsUC getListNotificationsUC,
  })  : _getListNotificationsUC = getListNotificationsUC,
        super(initialState ?? const NotificationState.initial());
  final GetListNotificationsUC _getListNotificationsUC;

  void reset() => state = const NotificationState.initial();

  Future<void> getListNotificationsUC() async {
    state = const NotificationState.loading();
    final result = await _getListNotificationsUC();

    result.when(
      left: (error) =>
          state = NotificationState.error(mapFailureToString(error)),
      right: (listNotification) => state = NotificationState.data(
          responseListNotificationsEntity: listNotification),
    );
  }
}
