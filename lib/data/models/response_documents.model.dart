// To parse this JSON data, do
//
//     final responseListDocumentsModel = responseListDocumentsModelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/domain/entities/document.entity.dart';
import 'package:davidocs/domain/entities/response_documents.entity.dart';

ResponseListDocumentsModel responseListDocumentsModelFromJson(String str) =>
    ResponseListDocumentsModel.fromJson(json.decode(str));

class ResponseListDocumentsModel implements ResponseListDocumentsEntity {
  @override
  bool error;
  @override
  String message;
  @override
  int numdocumentos;
  @override
  List<DocumentEntity> datos;
  @override
  DateTime timestamp;

  ResponseListDocumentsModel({
    required this.error,
    required this.message,
    required this.numdocumentos,
    required this.datos,
    required this.timestamp,
  });

  factory ResponseListDocumentsModel.fromJson(Map<String, dynamic> json) =>
      ResponseListDocumentsModel(
        error: json["error"],
        message: json["message"],
        numdocumentos: json["numdocumentos"],
        datos: json["datos"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}
