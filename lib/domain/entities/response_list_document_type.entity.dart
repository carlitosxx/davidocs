import 'package:davidocs/domain/entities/document_type.entity.dart';

class ResponseListDocumentTypeEntity {
  bool error;
  String message;
  int numtipodocumentos;
  List<DocumentTypeEntity> datos;
  DateTime timestamp;

  ResponseListDocumentTypeEntity({
    required this.error,
    required this.message,
    required this.numtipodocumentos,
    required this.datos,
    required this.timestamp,
  });
}
