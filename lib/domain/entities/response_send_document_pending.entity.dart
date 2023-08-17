class ResponseSendDocumentPendingEntity {
  bool error;
  String codigotoken;
  String message;
  String datos;
  DateTime timestamp;

  ResponseSendDocumentPendingEntity({
    required this.error,
    required this.codigotoken,
    required this.message,
    required this.datos,
    required this.timestamp,
  });
}
