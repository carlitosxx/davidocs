import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/domain/repositories/auth/auth.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPreferencesDataSource {
  saveTokenAndSubscriptionKey(String token, String subscriptionKey);
  rememberAccount(String user, String password);
  AccountOrFailure loadRememberedAccount();
}

class SharedPreferencesDataSourceImpl implements ISharedPreferencesDataSource {
  final Future<SharedPreferences> sharedPreferences;
  SharedPreferencesDataSourceImpl(this.sharedPreferences);

  @override
  saveTokenAndSubscriptionKey(String token, String subscriptionKey) async {
    final prefs = await sharedPreferences;
    await prefs.setString('token', token);
    await prefs.setString('subscription_key', subscriptionKey);
  }

  @override
  rememberAccount(String user, String password) async {
    final prefs = await sharedPreferences;
    await prefs.setString('user', user);
    await prefs.setString('password', password);
  }

  @override
  loadRememberedAccount() async {
    final prefs = await sharedPreferences;
    final user = prefs.getString('user') ?? '';
    final password = prefs.getString('password') ?? '';
    if (user == '') return Either.left('Account not found');
    final Map<String, String> account = {'user': user, 'password': password};

    return Either.right(account);
  }
}
