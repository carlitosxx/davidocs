import 'package:davidocs/domain/entities/document_type.entity.dart';

class DocumentTypeModel implements DocumentTypeEntity {
  @override
  String codigoempresa;
  @override
  String codigotipodocumento;
  @override
  String nombre;
  @override
  String totaldocumentos;

  DocumentTypeModel({
    required this.codigoempresa,
    required this.codigotipodocumento,
    required this.nombre,
    required this.totaldocumentos,
  });

  factory DocumentTypeModel.fromJson(Map<String, dynamic> json) =>
      DocumentTypeModel(
        codigoempresa: json["codigoempresa"],
        codigotipodocumento: json["codigotipodocumento"],
        nombre: json["nombre"],
        totaldocumentos: json["totaldocumentos"],
      );

  Map<String, dynamic> toJson() => {
        "codigoempresa": codigoempresa,
        "codigotipodocumento": codigotipodocumento,
        "nombre": nombre,
        "totaldocumentos": totaldocumentos,
      };
}
