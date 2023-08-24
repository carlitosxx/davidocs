class DownloadEntity {
  bool error;
  String message;
  DatosEntity datos;
  DateTime timestamp;

  DownloadEntity({
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
  String filename;
  String contenidodocumento;

  DocumentoEntity({
    required this.codigodocumento,
    required this.filename,
    required this.contenidodocumento,
  });
}
