// To parse this JSON data, do
//
//     final responseListNotificationsModel = responseListNotificationsModelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/domain/entities/notifications.entity.dart';
import 'package:davidocs/domain/entities/response_list_notifications.entity.dart';

ResponseListNotificationsModel responseListNotificationsModelFromJson(
        String str) =>
    ResponseListNotificationsModel.fromJson(json.decode(str));

class ResponseListNotificationsModel
    implements ResponseListNotificationsEntity {
  @override
  bool error;
  @override
  String message;
  @override
  int numnotificaciones;
  @override
  List<NotificationsEntity> datos;
  @override
  DateTime timestamp;

  ResponseListNotificationsModel({
    required this.error,
    required this.message,
    required this.numnotificaciones,
    required this.datos,
    required this.timestamp,
  });

  factory ResponseListNotificationsModel.fromJson(Map<String, dynamic> json) =>
      ResponseListNotificationsModel(
        error: json["error"],
        message: json["message"],
        numnotificaciones: json["numnotificaciones"],
        datos: json["datos"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}
