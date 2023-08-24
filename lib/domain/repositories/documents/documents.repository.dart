import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/domain/entities/document_detail.entity.dart';
import 'package:davidocs/domain/entities/download.entity.dart';
import 'package:davidocs/domain/entities/response_document.entity.dart';
import 'package:davidocs/domain/entities/response_documents.entity.dart';
import 'package:davidocs/domain/entities/response_documents_pending.entity.dart';
import 'package:davidocs/domain/entities/response_list_business.entity.dart';
import 'package:davidocs/domain/entities/response_list_document_type.entity.dart';
import 'package:davidocs/domain/entities/response_reject.entity.dart';
import 'package:davidocs/domain/entities/response_send_document_pending.entity.dart';
import 'package:davidocs/domain/entities/response_send_pin.entity.dart';

typedef DataOrFailure
    = Future<Either<HttpRequestFailure, ResponseDocumentsPendingEntity>>;
typedef DocumentOrFailure
    = Future<Either<HttpRequestFailure, ResponseDocumentPendingEntity>>;
typedef SendDocumentPendingOrFailure
    = Future<Either<HttpRequestFailure, ResponseSendDocumentPendingEntity>>;
typedef SendPinorFailure
    = Future<Either<HttpRequestFailure, ResponseSendPinEntity>>;
typedef RejectOrFailure
    = Future<Either<HttpRequestFailure, ResponseRejectEntity>>;

typedef ListBusinessOrFailure
    = Future<Either<HttpRequestFailure, ResponseListBusinessEntity>>;
typedef ListDocumentsTypeOrFailure
    = Future<Either<HttpRequestFailure, ResponseListDocumentTypeEntity>>;
typedef ListDocumentsOrFailure
    = Future<Either<HttpRequestFailure, ResponseListDocumentsEntity>>;
typedef DocumentDetailOrFailure
    = Future<Either<HttpRequestFailure, DocumentDetailEntity>>;
typedef DownloadOrFailure = Future<Either<HttpRequestFailure, DownloadEntity>>;

abstract class IDocumentsRepository {
  DataOrFailure getListDocumentsPending();
  DocumentOrFailure getDocumentPendingById(String documentID);
  SendDocumentPendingOrFailure sendDocumentPending(String documentID);
  SendPinorFailure sendPin(
    String codigodocumentopendiente,
    String codigotoken,
    String pinfirma,
    String infoequipo,
    String latitud,
    String longitud,
  );
  RejectOrFailure rejectDocumentPending(
    String codigodocumentopendiente,
    String motivo,
    String infoequipo,
    String latitud,
    String longitud,
  );
  ListBusinessOrFailure getListBusiness();
  ListDocumentsTypeOrFailure getListDocumentsType(String codigoempresa);

  ListDocumentsOrFailure getListDocuments(
      String codigoempresa, String codigotipodocumento);

  DocumentDetailOrFailure getDocumentDetail(String codigodocumento);
  DownloadOrFailure getDownloadFile(String codigodocumento);
}
