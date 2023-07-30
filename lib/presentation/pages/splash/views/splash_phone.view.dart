import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../splash.i18n.dart';

class SplashPhoneView extends ConsumerWidget {
  const SplashPhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Image.asset('assets/images/davidoc_white.png'),
            ),
            // Text(kBrand.i18n),
            TextButton(
                onPressed: () {
                  ref.read(appRouterProvider).goNamed('auth');
                },
                child: const Text('siguiente'))
          ],
        ),
      ),
    );
  }
}
