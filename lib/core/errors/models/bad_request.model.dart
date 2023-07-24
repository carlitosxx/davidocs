// import 'dart:convert';

// BadRequestModel badRequestModelFromJson(String str) =>
//     BadRequestModel.fromJson(json.decode(str));

// String badRequestModelToJson(BadRequestModel data) =>
//     json.encode(data.toJson());

// class BadRequestModel {
//   BadRequestModel({
//     required this.statusCode,
//     this.message,
//     required this.error,
//   });

//   final int statusCode;
//   final dynamic message;
//   final String error;

//   BadRequestModel copyWith({
//     int? statusCode,
//     dynamic message,
//     String? error,
//   }) =>
//       BadRequestModel(
//         statusCode: statusCode ?? this.statusCode,
//         message: message ?? this.message,
//         error: error ?? this.error,
//       );

//   factory BadRequestModel.fromJson(Map<String, dynamic> json) =>
//       BadRequestModel(
//         statusCode: json["statusCode"],
//         message: json["message"],
//         error: json["error"],
//       );

//   Map<String, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "message": message,
//         "error": error,
//       };
// }

// To parse this JSON data, do
//
//     final badRequestModel = badRequestModelFromJson(jsonString);

import 'dart:convert';

BadRequestModel badRequestModelFromJson(String str) =>
    BadRequestModel.fromJson(json.decode(str));

String badRequestModelToJson(BadRequestModel data) =>
    json.encode(data.toJson());

class BadRequestModel {
  final bool error;
  final String message;
  final DateTime timestamp;

  BadRequestModel({
    required this.error,
    required this.message,
    required this.timestamp,
  });

  BadRequestModel copyWith({
    bool? error,
    String? message,
    DateTime? timestamp,
  }) =>
      BadRequestModel(
        error: error ?? this.error,
        message: message ?? this.message,
        timestamp: timestamp ?? this.timestamp,
      );

  factory BadRequestModel.fromJson(Map<String, dynamic> json) =>
      BadRequestModel(
        error: json["error"],
        message: json["message"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "timestamp": timestamp.toIso8601String(),
      };
}
