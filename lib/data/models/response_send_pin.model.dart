import 'package:davidocs/domain/entities/response_send_pin.entity.dart';

import 'dart:convert';

ResponseSendPinModel responseSendPinModelFromJson(String str) =>
    ResponseSendPinModel.fromJson(json.decode(str));

class ResponseSendPinModel implements ResponseSendPinEntity {
  @override
  bool error;
  @override
  String message;
  @override
  String notificacion;
  @override
  DateTime timestamp;

  ResponseSendPinModel({
    required this.error,
    required this.message,
    required this.notificacion,
    required this.timestamp,
  });

  factory ResponseSendPinModel.fromJson(Map<String, dynamic> json) =>
      ResponseSendPinModel(
        error: json["error"],
        message: json["message"],
        notificacion: json["notificacion"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}
