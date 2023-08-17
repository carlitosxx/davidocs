// To parse this JSON data, do
//
//     final responseSendDocumentPendingModel = responseSendDocumentPendingModelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/domain/entities/response_send_document_pending.entity.dart';

ResponseSendDocumentPendingModel responseSendDocumentPendingModelFromJson(
        String str) =>
    ResponseSendDocumentPendingModel.fromJson(json.decode(str));

String responseSendDocumentPendingModelToJson(
        ResponseSendDocumentPendingModel data) =>
    json.encode(data.toJson());

class ResponseSendDocumentPendingModel
    implements ResponseSendDocumentPendingEntity {
  @override
  bool error;
  @override
  String codigotoken;
  @override
  String message;
  @override
  String datos;
  @override
  DateTime timestamp;

  ResponseSendDocumentPendingModel({
    required this.error,
    required this.codigotoken,
    required this.message,
    required this.datos,
    required this.timestamp,
  });

  ResponseSendDocumentPendingModel copyWith({
    bool? error,
    String? codigotoken,
    String? message,
    String? datos,
    DateTime? timestamp,
  }) =>
      ResponseSendDocumentPendingModel(
        error: error ?? this.error,
        codigotoken: codigotoken ?? this.codigotoken,
        message: message ?? this.message,
        datos: datos ?? this.datos,
        timestamp: timestamp ?? this.timestamp,
      );

  factory ResponseSendDocumentPendingModel.fromJson(
          Map<String, dynamic> json) =>
      ResponseSendDocumentPendingModel(
        error: json["error"],
        codigotoken: json["codigotoken"],
        message: json["message"],
        datos: json["datos"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "codigotoken": codigotoken,
        "message": message,
        "datos": datos,
        "timestamp": timestamp.toIso8601String(),
      };
}
