import 'package:davidocs/domain/repositories/auth/auth.repository.dart';

class GetSigninUC {
  GetSigninUC(this.authRepository);

  final AuthRepository authRepository;

  DataOrFailure call(String user, String password) async {
    return authRepository.getSignin(user, password);
  }
}
