import 'package:davidocs/core/utils/map_failure_to_string.util.dart';
import 'package:davidocs/data/datasources/local/save_token.datasource.dart';
import 'package:davidocs/data/datasources/remote/signin.datasource.dart';
import 'package:davidocs/data/repositories_impl/auth.repository_impl.dart';
import 'package:davidocs/domain/usecases/get_signin.usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:davidocs/domain/repositories/auth/auth.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'get_signin_state.dart';

export 'get_signin_state.dart';

part 'get_signin_state_notifier.dart';

// * provider
final signinNotifierProvider =
    StateNotifierProvider<SigninNotifier, SigninState>((ref) => SigninNotifier(
          getSigningUC: ref.watch(_getSigninUCProvider),
        ));

// * respositories Inject

final _authRepositoryProvider = Provider<IAuthRepository>((_) {
  return AuthRepositoryImpl(
    iSigninDataSource: SigninDataSourceImpl(
      Dio(),
    ),
    iTokenDataSource: TokenDataSourceImpl(
      SharedPreferences.getInstance(),
    ),
  );
});

// * usecases Inject
final _getSigninUCProvider = Provider<GetSigninUC>(
  (ref) {
    final repository = ref.watch(_authRepositoryProvider);

    return GetSigninUC(repository);
  },
);
