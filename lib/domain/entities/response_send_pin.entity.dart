class ResponseSendPinEntity {
  bool error;
  String message;
  String notificacion;
  DateTime timestamp;

  ResponseSendPinEntity({
    required this.error,
    required this.message,
    required this.notificacion,
    required this.timestamp,
  });
}
