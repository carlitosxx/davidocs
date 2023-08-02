import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class GetDocumentsPendingUC {
  GetDocumentsPendingUC(this.documentsRepository);
  final IDocumentsRepository documentsRepository;
  DataOrFailure call() async {
    return documentsRepository.getListDocumentsPending();
  }
}
