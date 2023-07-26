import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/datasources/local/save_token.datasource.dart';
import 'package:davidocs/data/datasources/remote/signin.datasource.dart';
import 'package:davidocs/domain/entities/response_signin.entity.dart';
import 'package:davidocs/domain/repositories/auth/auth.repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final ISigninDataSource _iSigninDataSource;
  final ITokenDataSource _iTokenDataSource;
  AuthRepositoryImpl(
      {required ISigninDataSource iSigninDataSource,
      required ITokenDataSource iTokenDataSource})
      : _iSigninDataSource = iSigninDataSource,
        _iTokenDataSource = iTokenDataSource;

  @override
  DataOrFailure getSignin(String user, String password) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      DataOrFailure dataOrFailureFuture =
          _iSigninDataSource.getLogin(user, password);
      Either<HttpRequestFailure, ResponseSigninEntity> dataOrFailure =
          await dataOrFailureFuture;
      dataOrFailure.whenOrNull(
        right: (value) async {
          await _iTokenDataSource.saveToken(value.subscriptionKey);
        },
      );
      return dataOrFailureFuture;
    } else {
      return Either.left(
        HttpRequestFailure.network(),
      );
    }
  }
}
