import 'package:davidocs/core/constants/environment.dart';
import 'package:davidocs/core/errors/http_request.error.dart';
import 'package:davidocs/core/errors/models/bad_request.model.dart';
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
      String url = "${Environment.apiUrl}subscription_key";
      Map<String, dynamic> data = {"Username": user, "Password": password};
      final response = await dio.post(url, data: data);

      if (response.statusCode == 200) {
        if (response.data['error'] == null) {
          final login = ResponseSigninModel.fromJson(response.data);
          return Either.right(
            login,
          );
        } else {
          final badRequestModel = BadRequestModel.fromJson(response.data);
          return Either.left(HttpRequestFailure.badRequest(badRequestModel));
        }
      } else {
        return Either.left(
          HttpRequestFailure.server(),
        );
      }
    } catch (e) {
      return Either.left(
        HttpRequestFailure.local(),
      );
    }
  }
}
