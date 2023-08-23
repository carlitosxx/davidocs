import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class GetDocumentDetailUC {
  GetDocumentDetailUC(this.documentsRepository);
  final IDocumentsRepository documentsRepository;
  DocumentDetailOrFailure call(String codigodocumento) {
    return documentsRepository.getDocumentDetail(codigodocumento);
  }
}
