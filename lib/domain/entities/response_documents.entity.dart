import 'package:davidocs/domain/entities/document.entity.dart';

class ResponseListDocumentsEntity {
  bool error;
  String message;
  int numdocumentos;
  List<DocumentEntity> datos;
  DateTime timestamp;

  ResponseListDocumentsEntity({
    required this.error,
    required this.message,
    required this.numdocumentos,
    required this.datos,
    required this.timestamp,
  });
}
