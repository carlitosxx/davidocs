import 'package:davidocs/core/constants/environment.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/errors/models/bad_request.model.dart';
import 'package:davidocs/core/utils/catch_dio_error.util.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/data/models/response_signin.model.dart';
import 'package:davidocs/domain/repositories/auth/auth.repository.dart';
import 'package:dio/dio.dart';

abstract class ISigninDataSource {
  DataOrFailure getLogin(String user, String password);
}

class SigninDataSourceImpl implements ISigninDataSource {
  final Dio dio;
  SigninDataSourceImpl(this.dio);

  @override
  DataOrFailure getLogin(String user, String password) async {
    try {
      String urlSubscriptionKey = "${Environment.apiUrl}subscription_key";
      String urlAccesToken = "${Environment.apiUrl}access_token";
      Map<String, dynamic> data = {"Username": user, "Password": password};

      final response = await dio.post(urlSubscriptionKey, data: data);
      if (response.statusCode == 200) {
        if (response.data['error'] == null) {
          final login = ResponseSigninModel.fromJson(response.data);
          final header = Options(
              headers: {"Jcdf-Apib-Subscription-Key": login.subscriptionKey});
          final responseAccessToken =
              await dio.post(urlAccesToken, options: header);
          if (responseAccessToken.data['error'] == null) {
            login.token = responseAccessToken.data["access_token"];
            return Either.right(
              login,
            );
          } else {
            final badRequestModel = BadRequestModel.fromJson(response.data);
            return Either.left(HttpRequestFailure.badRequest(badRequestModel));
          }
        } else {
          final badRequestModel = BadRequestModel.fromJson(response.data);
          return Either.left(HttpRequestFailure.badRequest(badRequestModel));
        }
      } else {
        return Either.left(
          HttpRequestFailure.server(),
        );
      }
    } on DioException catch (e) {
      // print(e);
      return Either.left(
        catchDioError(e),
      );
    } catch (e) {
      // print(e);
      return Either.left(
        HttpRequestFailure.local(),
      );
    }
  }
}
