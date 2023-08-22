import 'package:davidocs/domain/entities/business.entity.dart';

class ResponseListBusinessEntity {
  bool error;
  String message;
  int numempresas;
  List<Business> datos;
  DateTime timestamp;

  ResponseListBusinessEntity({
    required this.error,
    required this.message,
    required this.numempresas,
    required this.datos,
    required this.timestamp,
  });
}
