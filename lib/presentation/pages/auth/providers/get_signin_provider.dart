import 'package:davidocs/core/utils/map_failure_to_string.util.dart';
import 'package:davidocs/data/datasources/local/shared_preferences.datasource.dart';
import 'package:davidocs/data/datasources/remote/signin.datasource.dart';
import 'package:davidocs/data/repositories_impl/auth.repository_impl.dart';
import 'package:davidocs/domain/usecases/get_signin.usecase.dart';
import 'package:davidocs/domain/usecases/load_account_remembered.usecase.dart';
import 'package:davidocs/presentation/pages/auth/providers/load_account/load_account_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:davidocs/domain/repositories/auth/auth.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'get_signin/get_signin_state.dart';

export 'get_signin/get_signin_state.dart';

part 'get_signin/get_signin_state_notifier.dart';
part 'load_account/load_account_notifier.dart';

// * respositories Inject
final _repositoryProvider = Provider<IAuthRepository>(
  (_) {
    return AuthRepositoryImpl(
      iSigninDataSource: SigninDataSourceImpl(
        Dio(),
      ),
      iSharedPreferencesDataSource: SharedPreferencesDataSourceImpl(
        SharedPreferences.getInstance(),
      ),
    );
  },
);

// * usecases Inject
final _useCaseProvider = Provider<GetSigninUC>(
  (ref) {
    final repository = ref.watch(_repositoryProvider);

    return GetSigninUC(repository);
  },
);

final _loadAccountUseCaseProvider = Provider<LoadAccountRemembered>(
  (ref) {
    final repository = ref.watch(_repositoryProvider);

    return LoadAccountRemembered(repository);
  },
);

// * provider
final signinNotifierProvider =
    StateNotifierProvider<SigninNotifier, SigninState>(
  (ref) => SigninNotifier(
    getSigningUC: ref.watch(_useCaseProvider),
  ),
);
final loadNotifierProvider =
    StateNotifierProvider.autoDispose<LoadAccountNotifier, LoadAccountState>(
  (ref) => LoadAccountNotifier(
    loadAccountRememberedUC: ref.watch(_loadAccountUseCaseProvider),
  )..loadAccountRemembered(),
);
