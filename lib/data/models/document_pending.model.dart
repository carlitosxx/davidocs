import 'dart:convert';

import 'package:davidocs/domain/entities/document_pending.entity.dart';

DocumentPendingModel documentPendingModelFromJson(String str) =>
    DocumentPendingModel.fromJson(json.decode(str));

class DocumentPendingModel implements DocumentPendingEntity {
  @override
  String codigodocumentopendiente;
  @override
  String organizacion;
  @override
  String tipodocumento;
  @override
  String detalledocumento;
  @override
  String periodo;
  @override
  String correo;
  @override
  String celular;

  DocumentPendingModel({
    required this.codigodocumentopendiente,
    required this.organizacion,
    required this.tipodocumento,
    required this.detalledocumento,
    required this.periodo,
    required this.correo,
    required this.celular,
  });

  DocumentPendingModel copyWith({
    String? codigodocumentopendiente,
    String? organizacion,
    String? tipodocumento,
    String? detalledocumento,
    String? periodo,
    String? correo,
    String? celular,
  }) =>
      DocumentPendingModel(
        codigodocumentopendiente:
            codigodocumentopendiente ?? this.codigodocumentopendiente,
        organizacion: organizacion ?? this.organizacion,
        tipodocumento: tipodocumento ?? this.tipodocumento,
        detalledocumento: detalledocumento ?? this.detalledocumento,
        periodo: periodo ?? this.periodo,
        correo: correo ?? this.correo,
        celular: celular ?? this.celular,
      );

  factory DocumentPendingModel.fromJson(Map<String, dynamic> json) =>
      DocumentPendingModel(
        codigodocumentopendiente: json["codigodocumentopendiente"],
        organizacion: json["organizacion"],
        tipodocumento: json["tipodocumento"],
        detalledocumento: json["detalledocumento"],
        periodo: json["periodo"],
        correo: json["correo"],
        celular: json["celular"],
      );

  Map<String, dynamic> toJson() => {
        "codigodocumentopendiente": codigodocumentopendiente,
        "organizacion": organizacion,
        "tipodocumento": tipodocumento,
        "detalledocumento": detalledocumento,
        "periodo": periodo,
        "correo": correo,
        "celular": celular,
      };
}
