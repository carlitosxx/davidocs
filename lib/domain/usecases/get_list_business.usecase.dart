import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class GetListBusinessUC {
  GetListBusinessUC(this.documentsRepository);
  final IDocumentsRepository documentsRepository;
  ListBusinessOrFailure call() async {
    return documentsRepository.getListBusiness();
  }
}
