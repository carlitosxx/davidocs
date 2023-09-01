import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

class GetListNotificationsUC {
  GetListNotificationsUC(this.documentsRepository);
  final IDocumentsRepository documentsRepository;
  ListNotificationsOrFailure call() {
    return documentsRepository.getListNotifications();
  }
}
