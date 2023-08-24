// To parse this JSON data, do
//
//     final downloadModel = downloadModelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/domain/entities/download.entity.dart';

DownloadModel downloadModelFromJson(String str) =>
    DownloadModel.fromJson(json.decode(str));

class DownloadModel implements DownloadEntity {
  @override
  bool error;
  @override
  String message;
  @override
  DatosEntity datos;
  @override
  DateTime timestamp;

  DownloadModel({
    required this.error,
    required this.message,
    required this.datos,
    required this.timestamp,
  });

  factory DownloadModel.fromJson(Map<String, dynamic> json) => DownloadModel(
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

  factory DatosModel.fromJson(Map<String, dynamic> json) => DatosModel(
        documento: DocumentoModel.fromJson(json["documento"]),
      );
}

class DocumentoModel implements DocumentoEntity {
  @override
  String codigodocumento;
  @override
  String filename;
  @override
  String contenidodocumento;

  DocumentoModel({
    required this.codigodocumento,
    required this.filename,
    required this.contenidodocumento,
  });

  factory DocumentoModel.fromJson(Map<String, dynamic> json) => DocumentoModel(
        codigodocumento: json["codigodocumento"],
        filename: json["filename"],
        contenidodocumento: json["contenidodocumento"],
      );
}
