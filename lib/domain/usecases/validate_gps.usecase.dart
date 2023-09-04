import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class ValidateGpsUC {
  ValidateGpsUC(this.iDocumentsRepository);

  final IDocumentsRepository iDocumentsRepository;

  ServiceAndPermissionOrFailure call() async {
    return iDocumentsRepository.validateServiceAndPermission();
  }
}
