// To parse this JSON data, do
//
//     final responseListBusinessmodel = responseListBusinessmodelFromJson(jsonString);

import 'dart:convert';

import 'package:davidocs/domain/entities/business.entity.dart';
import 'package:davidocs/domain/entities/response_list_business.entity.dart';

ResponseListBusinessmodel responseListBusinessmodelFromJson(String str) =>
    ResponseListBusinessmodel.fromJson(json.decode(str));

// String responseListBusinessmodelToJson(ResponseListBusinessmodel data) => json.encode(data.toJson());

class ResponseListBusinessmodel implements ResponseListBusinessEntity {
  @override
  bool error;
  @override
  String message;
  @override
  int numempresas;
  @override
  List<Business> datos;
  @override
  DateTime timestamp;

  ResponseListBusinessmodel({
    required this.error,
    required this.message,
    required this.numempresas,
    required this.datos,
    required this.timestamp,
  });

  factory ResponseListBusinessmodel.fromJson(Map<String, dynamic> json) =>
      ResponseListBusinessmodel(
        error: json["error"],
        message: json["message"],
        numempresas: json["numempresas"],
        datos: json["datos"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}

class BusinessModel implements Business {
  @override
  String codigoempresa;
  @override
  String nombre;
  @override
  String totaldocumentos;

  BusinessModel({
    required this.codigoempresa,
    required this.nombre,
    required this.totaldocumentos,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
        codigoempresa: json["codigoempresa"],
        nombre: json["nombre"],
        totaldocumentos: json["totaldocumentos"],
      );
}
