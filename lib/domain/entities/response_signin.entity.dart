class ResponseSigninEntity {
  String subscriptionKey;
  int expiresIn;
  String documento;
  String nombre;
  String correo;
  String celular;
  String direccion;
  String avatar;
  DateTime timestamp;

  ResponseSigninEntity({
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
}
