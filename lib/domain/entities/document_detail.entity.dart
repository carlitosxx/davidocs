class DocumentDetailEntity {
  bool error;
  String message;
  DatosEntity datos;
  DateTime timestamp;

  DocumentDetailEntity({
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
  String codigodocumento;
  String imgPrevia;
  String detallefirma;

  DocumentoEntity({
    required this.codigodocumento,
    required this.imgPrevia,
    required this.detallefirma,
  });
}
