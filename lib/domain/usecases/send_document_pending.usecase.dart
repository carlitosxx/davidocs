import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class SendDocumentPendingUC {
  SendDocumentPendingUC(this.documentsRepository);
  final IDocumentsRepository documentsRepository;
  SendDocumentPendingOrFailure call({required String documentID}) async {
    return documentsRepository.sendDocumentPending(documentID);
  }
}
