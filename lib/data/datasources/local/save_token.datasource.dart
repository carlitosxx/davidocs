import 'package:shared_preferences/shared_preferences.dart';

abstract class ITokenDataSource {
  saveToken(String token);
}

class TokenDataSourceImpl implements ITokenDataSource {
  final SharedPreferences sharedPreferences;
  TokenDataSourceImpl(this.sharedPreferences);

  @override
  saveToken(String token) {
    sharedPreferences.setString('token', token);
  }
}
