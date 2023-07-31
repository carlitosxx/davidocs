// To parse this JSON data, do
//
//     final responseDocumentsPendingModel = responseDocumentsPendingModelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/data/models/document_pending.model.dart';
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
        datos: List<DocumentPendingModel>.from(
            json["datos"].map((x) => DocumentPendingModel.fromJson(x))),
        timestamp: DateTime.parse(json["timestamp"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "error": error,
  //       "message": message,
  //       "numdocumentos": numdocumentos,
  //       "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
  //       "timestamp": timestamp.toIso8601String(),
  //     };
}

// class Dato {
//   String codigodocumentopendiente;
//   String organizacion;
//   String tipodocumento;
//   String detalledocumento;
//   String periodo;
//   String correo;
//   String celular;

//   Dato({
//     required this.codigodocumentopendiente,
//     required this.organizacion,
//     required this.tipodocumento,
//     required this.detalledocumento,
//     required this.periodo,
//     required this.correo,
//     required this.celular,
//   });

//   Dato copyWith({
//     String? codigodocumentopendiente,
//     String? organizacion,
//     String? tipodocumento,
//     String? detalledocumento,
//     String? periodo,
//     String? correo,
//     String? celular,
//   }) =>
//       Dato(
//         codigodocumentopendiente:
//             codigodocumentopendiente ?? this.codigodocumentopendiente,
//         organizacion: organizacion ?? this.organizacion,
//         tipodocumento: tipodocumento ?? this.tipodocumento,
//         detalledocumento: detalledocumento ?? this.detalledocumento,
//         periodo: periodo ?? this.periodo,
//         correo: correo ?? this.correo,
//         celular: celular ?? this.celular,
//       );

//   factory Dato.fromJson(Map<String, dynamic> json) => Dato(
//         codigodocumentopendiente: json["codigodocumentopendiente"],
//         organizacion: json["organizacion"],
//         tipodocumento: json["tipodocumento"],
//         detalledocumento: json["detalledocumento"],
//         periodo: json["periodo"],
//         correo: json["correo"],
//         celular: json["celular"],
//       );

//   Map<String, dynamic> toJson() => {
//         "codigodocumentopendiente": codigodocumentopendiente,
//         "organizacion": organizacion,
//         "tipodocumento": tipodocumento,
//         "detalledocumento": detalledocumento,
//         "periodo": periodo,
//         "correo": correo,
//         "celular": celular,
//       };
// }



// // To parse this JSON data, do
// //
// //     final responseDocumentsPendingModel = responseDocumentsPendingModelFromJson(jsonString);

// import 'dart:convert';

// import 'package:davidocs/data/models/document_pending.model.dart';
// import 'package:davidocs/domain/entities/document_pending.entity.dart';
// import 'package:davidocs/domain/entities/response_documents_pending.entity.dart';

// ResponseDocumentsPendingModel responseDocumentsPendingModelFromJson(
//         String str) =>
//     ResponseDocumentsPendingModel.fromJson(json.decode(str));

// String responseDocumentsPendingModelToJson(
//         ResponseDocumentsPendingModel data) =>
//     json.encode(data.toJson());

// class ResponseDocumentsPendingModel implements ResponseDocumentsPendingEntity {
//   @override
//   bool error;
//   @override
//   String message;
//   @override
//   int numdocumentos;
//   @override
//   List<DocumentPendingEntity> datos;
//   @override
//   DateTime timestamp;

//   ResponseDocumentsPendingModel({
//     required this.error,
//     required this.message,
//     required this.numdocumentos,
//     required this.datos,
//     required this.timestamp,
//   });

//   ResponseDocumentsPendingModel copyWith({
//     bool? error,
//     String? message,
//     int? numdocumentos,
//     List<DocumentPendingEntity>? datos,
//     DateTime? timestamp,
//   }) =>
//       ResponseDocumentsPendingModel(
//         error: error ?? this.error,
//         message: message ?? this.message,
//         numdocumentos: numdocumentos ?? this.numdocumentos,
//         datos: datos ?? this.datos,
//         timestamp: timestamp ?? this.timestamp,
//       );

//   factory ResponseDocumentsPendingModel.fromJson(Map<String, dynamic> json) =>
//       ResponseDocumentsPendingModel(
//         error: json["error"],
//         message: json["message"],
//         numdocumentos: json["numdocumentos"],
//         datos: List<DocumentPendingEntity>.from(json["datos"].map((x) => DocumentPendingEntity.fromJson(x))),
//         timestamp: DateTime.parse(json["timestamp"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "error": error,
//         "message": message,
//         "numdocumentos": numdocumentos,
//         "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
//         "timestamp": timestamp.toIso8601String(),
//       };
// }

