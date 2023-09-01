import 'package:davidocs/domain/entities/notifications.entity.dart';

class ResponseListNotificationsEntity {
  bool error;
  String message;
  int numnotificaciones;
  List<NotificationsEntity> datos;
  DateTime timestamp;

  ResponseListNotificationsEntity({
    required this.error,
    required this.message,
    required this.numnotificaciones,
    required this.datos,
    required this.timestamp,
  });
}
