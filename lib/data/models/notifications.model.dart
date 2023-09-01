import 'package:davidocs/domain/entities/notifications.entity.dart';

class NotificationsModel implements NotificationsEntity {
  @override
  String codigodocumento;
  @override
  String empresa;
  @override
  String tipodocumento;
  @override
  String periodo;
  @override
  String disponible;

  NotificationsModel({
    required this.codigodocumento,
    required this.empresa,
    required this.tipodocumento,
    required this.periodo,
    required this.disponible,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        codigodocumento: json["codigodocumento"],
        empresa: json["empresa"],
        tipodocumento: json["tipodocumento"],
        periodo: json["periodo"],
        disponible: json["disponible"],
      );
}
