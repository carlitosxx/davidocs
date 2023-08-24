import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../splash.i18n.dart';

class SplashPhoneView extends ConsumerStatefulWidget {
  const SplashPhoneView({super.key});

  @override
  SplashPhoneViewState createState() => SplashPhoneViewState();
}

class SplashPhoneViewState extends ConsumerState<SplashPhoneView> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // Esperar 2 segundos usando Future.delayed
    await Future.delayed(const Duration(seconds: 2));

    // Navegar a la siguiente pantalla
    ref.read(appRouterProvider).goNamed('auth');
  }

  @override
  Widget build(BuildContext context) {
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
            // TextButton(
            //   onPressed: () {
            //     ref.read(appRouterProvider).goNamed('auth');
            //   },
            //   child: const Text('siguiente'),
            // )
          ],
        ),
      ),
    );
  }
}
