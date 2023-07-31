import 'package:shared_preferences/shared_preferences.dart';

abstract class ITokenDataSource {
  saveTokenAndSubscriptionKey(String token, String subscriptionKey);
}

class TokenDataSourceImpl implements ITokenDataSource {
  final Future<SharedPreferences> sharedPreferences;
  TokenDataSourceImpl(this.sharedPreferences);

  @override
  saveTokenAndSubscriptionKey(String token, String subscriptionKey) async {
    final prefs = await sharedPreferences;
    await prefs.setString('token', token);
    await prefs.setString('subscription_key', subscriptionKey);
  }
}
