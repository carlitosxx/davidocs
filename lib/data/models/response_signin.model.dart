// To parse this JSON data, do
//
//     final responseSigninModel = responseSigninModelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/domain/entities/response_signin.entity.dart';

ResponseSigninModel responseSigninModelFromJson(String str) =>
    ResponseSigninModel.fromJson(json.decode(str));

String responseSigninModelToJson(ResponseSigninModel data) =>
    json.encode(data.toJson());

class ResponseSigninModel implements ResponseSigninEntity {
  @override
  String subscriptionKey;
  @override
  int expiresIn;
  @override
  String documento;
  @override
  String nombre;
  @override
  String correo;
  @override
  String celular;
  @override
  String direccion;
  @override
  String avatar;
  @override
  DateTime timestamp;

  ResponseSigninModel({
    required this.subscriptionKey,
    required this.expiresIn,
    required this.documento,
    required this.nombre,
    required this.correo,
    required this.celular,
    required this.direccion,
    required this.avatar,
    required this.timestamp,
  });

  ResponseSigninModel copyWith({
    String? subscriptionKey,
    int? expiresIn,
    String? documento,
    String? nombre,
    String? correo,
    String? celular,
    String? direccion,
    String? avatar,
    DateTime? timestamp,
  }) =>
      ResponseSigninModel(
        subscriptionKey: subscriptionKey ?? this.subscriptionKey,
        expiresIn: expiresIn ?? this.expiresIn,
        documento: documento ?? this.documento,
        nombre: nombre ?? this.nombre,
        correo: correo ?? this.correo,
        celular: celular ?? this.celular,
        direccion: direccion ?? this.direccion,
        avatar: avatar ?? this.avatar,
        timestamp: timestamp ?? this.timestamp,
      );

  factory ResponseSigninModel.fromJson(Map<String, dynamic> json) =>
      ResponseSigninModel(
        subscriptionKey: json["subscription_key"],
        expiresIn: json["expires_in"],
        documento: json["documento"],
        nombre: json["nombre"],
        correo: json["correo"],
        celular: json["celular"],
        direccion: json["direccion"],
        avatar: json["avatar"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "subscription_key": subscriptionKey,
        "expires_in": expiresIn,
        "documento": documento,
        "nombre": nombre,
        "correo": correo,
        "celular": celular,
        "direccion": direccion,
        "avatar": avatar,
        "timestamp": timestamp.toIso8601String(),
      };
}
