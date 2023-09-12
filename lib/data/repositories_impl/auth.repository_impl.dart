import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/datasources/local/shared_preferences.datasource.dart';
import 'package:davidocs/data/datasources/remote/signin.datasource.dart';
import 'package:davidocs/domain/entities/response_signin.entity.dart';
import 'package:davidocs/domain/repositories/auth/auth.repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final ISigninDataSource _iSigninDataSource;
  final ISharedPreferencesDataSource _iSharedPreferencesDataSource;
  AuthRepositoryImpl(
      {required ISigninDataSource iSigninDataSource,
      required ISharedPreferencesDataSource iSharedPreferencesDataSource})
      : _iSigninDataSource = iSigninDataSource,
        _iSharedPreferencesDataSource = iSharedPreferencesDataSource;

  @override
  DataOrFailure getSignin(String user, String password, bool isRemember) async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        DataOrFailure dataOrFailureFuture =
            _iSigninDataSource.getLogin(user, password);
        Either<HttpRequestFailure, ResponseSigninEntity> dataOrFailure =
            await dataOrFailureFuture;
        dataOrFailure.whenOrNull(
          right: (value) async {
            if (isRemember) {
              await _iSharedPreferencesDataSource.rememberAccount(
                  user, password);
            }
            await _iSharedPreferencesDataSource.saveTokenAndSubscriptionKey(
                value.token ?? '', value.subscriptionKey);
          },
        );
        return dataOrFailureFuture;
      } else {
        return Either.left(
          HttpRequestFailure.network(),
        );
      }
    } catch (e) {
      // print(e);
      return Either.left(
        HttpRequestFailure.network(),
      );
    }
  }

  @override
  AccountOrFailure loadAccountRemembered() {
    AccountOrFailure accountOrFailure =
        _iSharedPreferencesDataSource.loadRememberedAccount();
    return accountOrFailure;
  }
}
