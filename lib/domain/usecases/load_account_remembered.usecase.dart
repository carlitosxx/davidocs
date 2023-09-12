import 'package:davidocs/domain/repositories/auth/auth.repository.dart';

class LoadAccountRemembered {
  LoadAccountRemembered(this.authRepository);

  final IAuthRepository authRepository;

  AccountOrFailure call() async {
    return authRepository.loadAccountRemembered();
  }
}
