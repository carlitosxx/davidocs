import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class GetDocumentPendingByIdUC {
  GetDocumentPendingByIdUC(this.documentsRepository);
  final IDocumentsRepository documentsRepository;
  DocumentOrFailure call({required String documentID}) async {
    return documentsRepository.getDocumentPendingById(documentID);
  }
}
