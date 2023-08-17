// To parse this JSON data, do
//
//     final responseRejectModel = responseRejectModelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/domain/entities/response_reject.entity.dart';

ResponseRejectModel responseRejectModelFromJson(String str) =>
    ResponseRejectModel.fromJson(json.decode(str));

String responseRejectModelToJson(ResponseRejectModel data) =>
    json.encode(data.toJson());

class ResponseRejectModel implements ResponseRejectEntity {
  @override
  bool error;
  @override
  String message;
  @override
  String notificacion;
  @override
  DateTime timestamp;

  ResponseRejectModel({
    required this.error,
    required this.message,
    required this.notificacion,
    required this.timestamp,
  });

  factory ResponseRejectModel.fromJson(Map<String, dynamic> json) =>
      ResponseRejectModel(
        error: json["error"],
        message: json["message"],
        notificacion: json["notificacion"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "notificacion": notificacion,
        "timestamp": timestamp.toIso8601String(),
      };
}
