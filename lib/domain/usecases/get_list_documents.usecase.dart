import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class GetListDocumentsUC {
  GetListDocumentsUC(this.documentsRepository);
  final IDocumentsRepository documentsRepository;
  ListDocumentsOrFailure call(
      String codigoempresa, String codigotipodocumento) {
    return documentsRepository.getListDocuments(
        codigoempresa, codigotipodocumento);
  }
}
