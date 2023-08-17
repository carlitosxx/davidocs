import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class SendPinUC {
  SendPinUC(this.documentRepository);
  final IDocumentsRepository documentRepository;
  SendPinorFailure call({
    required String codigodocumentopendiente,
    required String codigotoken,
    required String pinfirma,
    required String infoequipo,
    required String latitud,
    required String longitud,
  }) async {
    return documentRepository.sendPin(codigodocumentopendiente, codigotoken,
        pinfirma, infoequipo, latitud, longitud);
  }
}
