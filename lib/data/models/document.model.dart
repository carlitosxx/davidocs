import 'package:davidocs/domain/entities/document.entity.dart';

class DocumentModel implements DocumentEntity {
  @override
  String codigodocumento;
  @override
  String visualizado;
  @override
  String tipodocumento;
  @override
  String detalledocumento;
  @override
  String periodo;
  @override
  String totaldescargas;
  @override
  String historicoEnt;
  @override
  String historicoVis;
  @override
  String historicoDes;
  @override
  String observacion;
  @override
  String respuesta;

  DocumentModel({
    required this.codigodocumento,
    required this.visualizado,
    required this.tipodocumento,
    required this.detalledocumento,
    required this.periodo,
    required this.totaldescargas,
    required this.historicoEnt,
    required this.historicoVis,
    required this.historicoDes,
    required this.observacion,
    required this.respuesta,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        codigodocumento: json["codigodocumento"],
        visualizado: json["visualizado"],
        tipodocumento: json["tipodocumento"],
        detalledocumento: json["detalledocumento"],
        periodo: json["periodo"],
        totaldescargas: json["totaldescargas"],
        historicoEnt: json["historico_ent"],
        historicoVis: json["historico_vis"],
        historicoDes: json["historico_des"],
        observacion: json["observacion"],
        respuesta: json["respuesta"],
      );

  Map<String, dynamic> toJson() => {
        "codigodocumento": codigodocumento,
        "visualizado": visualizado,
        "tipodocumento": tipodocumento,
        "detalledocumento": detalledocumento,
        "periodo": periodo,
        "totaldescargas": totaldescargas,
        "historico_ent": historicoEnt,
        "historico_vis": historicoVis,
        "historico_des": historicoDes,
        "observacion": observacion,
        "respuesta": respuesta,
      };
}
