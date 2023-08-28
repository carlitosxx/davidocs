import 'package:davidocs/presentation/pages/auth/auth.page.dart';
import 'package:davidocs/presentation/pages/home/home.page.dart';
import 'package:davidocs/presentation/pages/home/views/detail_sign_phone.view.dart';
import 'package:davidocs/presentation/pages/home/views/document_detail_phone.view.dart';
import 'package:davidocs/presentation/pages/home/views/document_phone.view.dart';
import 'package:davidocs/presentation/pages/home/views/document_type_phone.view.dart';
import 'package:davidocs/presentation/pages/home/views/notification_phone.view.dart';
import 'package:davidocs/presentation/pages/pending_documents/pending_documents.page.dart';
import 'package:davidocs/presentation/pages/pending_documents/views/pending_document_phone.view.dart';
import 'package:davidocs/presentation/pages/splash/splash.page.dart';
import 'package:davidocs/presentation/pages/welcome/welcome.page.dart';
import 'package:flutter/material.dart';
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
    GoRoute(
      name: 'document_type',
      path: '/document_type',
      builder: (context, state) => I18n(
        child: const DocumentTypePhoneView(),
      ),
    ),
    GoRoute(
      name: 'document',
      path: '/document',
      builder: (context, state) => I18n(
        child: const DocumentPhoneView(),
      ),
    ),
    GoRoute(
      name: 'document_detail',
      path: '/document_detail',
      builder: (context, state) => I18n(
        child: const DocumentDetailPhoneView(),
      ),
    ),
    GoRoute(
      name: 'detail_sign',
      path: '/detail_sign',
      builder: (context, state) => I18n(
        child: const DetailSignPhoneView(),
      ),
    ),
    GoRoute(
      name: 'welcome',
      path: '/welcome',
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        ),
        child: I18n(child: const WelcomePage()),
      ),
    ),
    GoRoute(
      name: 'pending_documents',
      path: '/pending_documents',
      builder: (context, state) => I18n(child: const PendingDocumentsPage()),
    ),
    GoRoute(
      name: 'pending_document',
      path: '/pending_document',
      builder: (context, state) => I18n(
        child: PendingDocumentPhoneView(
          documentID: state.extra! as String,
        ),
      ),
    ),
    GoRoute(
      name: 'notification',
      path: '/notification',
      builder: (context, state) => I18n(
        child: const NotificationPhoneView(),
      ),
    )
  ]);
});
