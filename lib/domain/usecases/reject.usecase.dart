import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class RejectUC {
  RejectUC(this.documentRepository);
  final IDocumentsRepository documentRepository;
  RejectOrFailure call({
    required String codigodocumentopendiente,
    required String motivo,
    required String infoequipo,
    required String latitud,
    required String longitud,
  }) async {
    return documentRepository.rejectDocumentPending(
        codigodocumentopendiente, motivo, infoequipo, latitud, longitud);
  }
}
