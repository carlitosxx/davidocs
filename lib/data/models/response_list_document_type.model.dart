// To parse this JSON data, do
//
//     final responseListDocumentTypeModel = responseListDocumentTypeModelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/domain/entities/document_type.entity.dart';
import 'package:davidocs/domain/entities/response_list_document_type.entity.dart';

ResponseListDocumentTypeModel responseListDocumentTypeModelFromJson(
        String str) =>
    ResponseListDocumentTypeModel.fromJson(json.decode(str));

class ResponseListDocumentTypeModel implements ResponseListDocumentTypeEntity {
  @override
  bool error;
  @override
  String message;
  @override
  int numtipodocumentos;
  @override
  List<DocumentTypeEntity> datos;
  @override
  DateTime timestamp;

  ResponseListDocumentTypeModel({
    required this.error,
    required this.message,
    required this.numtipodocumentos,
    required this.datos,
    required this.timestamp,
  });

  factory ResponseListDocumentTypeModel.fromJson(Map<String, dynamic> json) =>
      ResponseListDocumentTypeModel(
        error: json["error"],
        message: json["message"],
        numtipodocumentos: json["numtipodocumentos"],
        datos: json["datos"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}
