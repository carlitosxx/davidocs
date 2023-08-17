class ResponseRejectEntity {
  bool error;
  String message;
  String notificacion;
  DateTime timestamp;

  ResponseRejectEntity({
    required this.error,
    required this.message,
    required this.notificacion,
    required this.timestamp,
  });
}
