import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/domain/entities/response_signin.entity.dart';

typedef DataOrFailure
    = Future<Either<HttpRequestFailure, ResponseSigninEntity>>;

abstract class AuthRepository {
  DataOrFailure getSignin(String user, String password);
}
