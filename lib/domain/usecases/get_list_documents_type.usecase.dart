import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class GetListDocumentsTypeUC {
  GetListDocumentsTypeUC(this.documentsRepository);
  final IDocumentsRepository documentsRepository;
  ListDocumentsTypeOrFailure call(String codigoempresa) async {
    return documentsRepository.getListDocumentsType(codigoempresa);
  }
}
