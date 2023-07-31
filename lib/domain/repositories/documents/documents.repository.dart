import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/domain/entities/response_documents_pending.entity.dart';

typedef DataOrFailure
    = Future<Either<HttpRequestFailure, ResponseDocumentsPendingEntity>>;

abstract class IDocumentsRepository {
  DataOrFailure getListDocumentsPending();
}
