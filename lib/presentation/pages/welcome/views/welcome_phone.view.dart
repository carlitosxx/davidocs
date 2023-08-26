import 'package:davidocs/presentation/pages/auth/providers/get_signin/get_signin_provider.dart';
import 'package:davidocs/presentation/pages/welcome/welcome.i18n.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:davidocs/presentation/widgets/button.widget.dart';
import 'package:davidocs/presentation/widgets/clipper_top_login.widget.dart';
import 'package:davidocs/presentation/widgets/spacing_height_small.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePhoneView extends ConsumerWidget {
  const WelcomePhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signinNotifierProvider);
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                const ClipperTopLogin(),
                Positioned(
                  top: MediaQuery.of(context).size.height / 8,
                  child: Image.asset('assets/images/davidoc_white.png',
                      width: 280),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kWelcome.i18n,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SpacingHeightSmall(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withOpacity(.09)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kFullname.i18n,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        signinState.maybeWhen(
                          orElse: () => const Text(''),
                          data: (value) => Text(value.nombre),
                        ),
                        const SpacingHeightSmall(),
                        Text(
                          kDNI.i18n,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        signinState.maybeWhen(
                          orElse: () => const Text(''),
                          data: (value) => Text(value.documento),
                        ),
                        const SpacingHeightSmall(),
                        Text(
                          kEmail.i18n,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        signinState.maybeWhen(
                          orElse: () => const Text(''),
                          data: (value) => Text(value.correo),
                        ),
                        const SpacingHeightSmall(),
                        Text(
                          kPhone.i18n,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        signinState.maybeWhen(
                          orElse: () => const Text(''),
                          data: (value) => Text(value.celular),
                        ),
                        const SpacingHeightSmall(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        width: double.infinity,
        child: ButtonWidget(
          text: kNext.i18n,
          isPrimary: true,
          onButtonClick: () {
            ref.read(appRouterProvider).goNamed('home');
          },
        ),
      ),
    );
  }
}
