import "package:dio/dio.dart";
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString('token');
    final subscriptionKey = storage.getString('subscription_key');
    if (token != null && token.isNotEmpty ||
        subscriptionKey != null && subscriptionKey.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['Jcdf-Apib-Subscription-Key'] = subscriptionKey;
    }
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}
