// To parse this JSON data, do
//
//     final responseDocumentsPendingModel = responseDocumentsPendingModelFromJson(jsonString);

import 'dart:convert';

// import 'package:davidocs/data/models/document_pending.model.dart';
import 'package:davidocs/domain/entities/document_pending.entity.dart';
import 'package:davidocs/domain/entities/response_documents_pending.entity.dart';

ResponseDocumentsPendingModel responseDocumentsPendingModelFromJson(
        String str) =>
    ResponseDocumentsPendingModel.fromJson(json.decode(str));

// String responseDocumentsPendingModelToJson(
//         ResponseDocumentsPendingModel data) =>
//     json.encode(data.toJson());

class ResponseDocumentsPendingModel implements ResponseDocumentsPendingEntity {
  @override
  bool error;
  @override
  String message;
  @override
  int numdocumentos;
  @override
  List<DocumentPendingEntity> datos;
  @override
  DateTime timestamp;

  ResponseDocumentsPendingModel({
    required this.error,
    required this.message,
    required this.numdocumentos,
    required this.datos,
    required this.timestamp,
  });

  ResponseDocumentsPendingModel copyWith({
    bool? error,
    String? message,
    int? numdocumentos,
    List<DocumentPendingEntity>? datos,
    DateTime? timestamp,
  }) =>
      ResponseDocumentsPendingModel(
        error: error ?? this.error,
        message: message ?? this.message,
        numdocumentos: numdocumentos ?? this.numdocumentos,
        datos: datos ?? this.datos,
        timestamp: timestamp ?? this.timestamp,
      );

  factory ResponseDocumentsPendingModel.fromJson(Map<String, dynamic> json) =>
      ResponseDocumentsPendingModel(
        error: json["error"],
        message: json["message"],
        numdocumentos: json["numdocumentos"],
        datos: json["datos"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}
