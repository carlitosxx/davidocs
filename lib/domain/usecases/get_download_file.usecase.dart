import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class GetDownloadFileUC {
  GetDownloadFileUC(this._iDocumentsRepository);
  final IDocumentsRepository _iDocumentsRepository;
  DownloadOrFailure call(String codigodocumento) {
    return _iDocumentsRepository.getDownloadFile(codigodocumento);
  }
}
