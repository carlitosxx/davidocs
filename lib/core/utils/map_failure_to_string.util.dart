import 'package:davidocs/core/errors/http_request.error.dart';

String mapFailureToString(HttpRequestFailure failure) {
  return failure.when(
      network: () => 'Hubo un problema de red',
      notFound: () => 'El recurso no fue encontrado',
      server: () => 'Hubo un problema en el servidor',
      unauthorized: () => 'No estas autorizado',
      badRequest: (error) {
        return error.message;
      },
      local: () => 'Hubo un problema local o desconocido');
}
