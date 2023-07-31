import 'package:davidocs/domain/entities/document_pending.entity.dart';

class ResponseDocumentsPendingEntity {
  bool error;
  String message;
  int numdocumentos;
  List<DocumentPendingEntity> datos;
  DateTime timestamp;

  ResponseDocumentsPendingEntity({
    required this.error,
    required this.message,
    required this.numdocumentos,
    required this.datos,
    required this.timestamp,
  });
}
