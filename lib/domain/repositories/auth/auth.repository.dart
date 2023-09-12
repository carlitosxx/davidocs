import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/domain/entities/response_signin.entity.dart';

typedef DataOrFailure
    = Future<Either<HttpRequestFailure, ResponseSigninEntity>>;
typedef AccountOrFailure = Future<Either<String, Map<String, String>>>;

abstract class IAuthRepository {
  DataOrFailure getSignin(String user, String password, bool isRemember);
  AccountOrFailure loadAccountRemembered();
}
