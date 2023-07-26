import 'package:davidocs/domain/repositories/auth/auth.repository.dart';

class GetSigninUC {
  GetSigninUC(this.authRepository);

  final IAuthRepository authRepository;

  DataOrFailure call({required String user, required String password}) async {
    return authRepository.getSignin(user, password);
  }
}
