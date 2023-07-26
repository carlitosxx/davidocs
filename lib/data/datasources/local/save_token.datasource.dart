import 'package:shared_preferences/shared_preferences.dart';

abstract class ITokenDataSource {
  saveToken(String token);
}

class TokenDataSourceImpl implements ITokenDataSource {
  final Future<SharedPreferences> sharedPreferences;
  TokenDataSourceImpl(this.sharedPreferences);

  @override
  saveToken(String token) async {
    final prefs = await sharedPreferences;
    await prefs.setString('token', token);
  }
}
