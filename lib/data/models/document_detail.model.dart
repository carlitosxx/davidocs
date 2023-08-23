// To parse this JSON data, do
//
//     final documentDetailModel = documentDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/domain/entities/document_detail.entity.dart';

DocumentDetailModel documentDetailModelFromJson(String str) =>
    DocumentDetailModel.fromJson(json.decode(str));

class DocumentDetailModel implements DocumentDetailEntity {
  @override
  bool error;
  @override
  String message;
  @override
  DatosEntity datos;
  @override
  DateTime timestamp;

  DocumentDetailModel({
    required this.error,
    required this.message,
    required this.datos,
    required this.timestamp,
  });

  factory DocumentDetailModel.fromJson(Map<String, dynamic> json) =>
      DocumentDetailModel(
        error: json["error"],
        message: json["message"],
        datos: Datos.fromJson(json["datos"]),
        timestamp: DateTime.parse(json["timestamp"]),
      );
}

class Datos implements DatosEntity {
  @override
  DocumentoEntity documento;

  Datos({
    required this.documento,
  });

  factory Datos.fromJson(Map<String, dynamic> json) => Datos(
        documento: Documento.fromJson(json["documento"]),
      );
}

class Documento implements DocumentoEntity {
  @override
  String codigodocumento;
  @override
  String imgPrevia;
  @override
  String detallefirma;

  Documento({
    required this.codigodocumento,
    required this.imgPrevia,
    required this.detallefirma,
  });

  factory Documento.fromJson(Map<String, dynamic> json) => Documento(
        codigodocumento: json["codigodocumento"],
        imgPrevia: json["img_previa"],
        detallefirma: json["detallefirma"],
      );
}
