import 'package:davidocs/presentation/pages/auth/auth.page.dart';
import 'package:davidocs/presentation/pages/home/home.page.dart';
import 'package:davidocs/presentation/pages/splash/splash.page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_extension/i18n_widget.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => I18n(child: const SplashPage()),
    ),
    GoRoute(
      name: 'auth',
      path: '/auth',
      builder: (context, state) => I18n(child: const AuthPage()),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => I18n(child: const HomePage()),
    ),
  ]);
});
