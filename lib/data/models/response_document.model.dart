import 'dart:convert';

import 'package:davidocs/domain/entities/response_document.entity.dart'
    show ResponseDocumentPendingEntity, DatosEntity, DocumentoEntity;

ResponseDocumentPendingModel responseDocumentPendingModelFromJson(String str) =>
    ResponseDocumentPendingModel.fromJson(json.decode(str));

class ResponseDocumentPendingModel implements ResponseDocumentPendingEntity {
  @override
  bool error;
  @override
  String message;
  @override
  DatosEntity datos;
  @override
  DateTime timestamp;

  ResponseDocumentPendingModel({
    required this.error,
    required this.message,
    required this.datos,
    required this.timestamp,
  });

  ResponseDocumentPendingModel copyWith({
    bool? error,
    String? message,
    DatosEntity? datos,
    DateTime? timestamp,
  }) =>
      ResponseDocumentPendingModel(
        error: error ?? this.error,
        message: message ?? this.message,
        datos: datos ?? this.datos,
        timestamp: timestamp ?? this.timestamp,
      );

  factory ResponseDocumentPendingModel.fromJson(Map<String, dynamic> json) =>
      ResponseDocumentPendingModel(
        error: json["error"],
        message: json["message"],
        datos: DatosModel.fromJson(json["datos"]),
        timestamp: DateTime.parse(json["timestamp"]),
      );
}

class DatosModel implements DatosEntity {
  @override
  DocumentoEntity documento;

  DatosModel({
    required this.documento,
  });

  DatosModel copyWith({
    DocumentoEntity? documento,
  }) =>
      DatosModel(
        documento: documento ?? this.documento,
      );

  factory DatosModel.fromJson(Map<String, dynamic> json) => DatosModel(
        documento: DocumentoModel.fromJson(json["documento"]),
      );
}

class DocumentoModel implements DocumentoEntity {
  @override
  String codigodocumentopendiente;
  @override
  String docPrevio;

  DocumentoModel({
    required this.codigodocumentopendiente,
    required this.docPrevio,
  });

  DocumentoModel copyWith({
    String? codigodocumentopendiente,
    String? docPrevio,
  }) =>
      DocumentoModel(
        codigodocumentopendiente:
            codigodocumentopendiente ?? this.codigodocumentopendiente,
        docPrevio: docPrevio ?? this.docPrevio,
      );

  factory DocumentoModel.fromJson(Map<String, dynamic> json) => DocumentoModel(
        codigodocumentopendiente: json["codigodocumentopendiente"],
        docPrevio: json["doc_previo"],
      );
}
