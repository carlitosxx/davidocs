abstract class ResponseDocumentPendingEntity {
  bool error;
  String message;
  DatosEntity datos;
  DateTime timestamp;

  ResponseDocumentPendingEntity({
    required this.error,
    required this.message,
    required this.datos,
    required this.timestamp,
  });
}

class DatosEntity {
  DocumentoEntity documento;

  DatosEntity({
    required this.documento,
  });
}

class DocumentoEntity {
  String codigodocumentopendiente;
  String docPrevio;

  DocumentoEntity({
    required this.codigodocumentopendiente,
    required this.docPrevio,
  });
}
