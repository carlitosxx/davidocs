import 'package:davidocs/presentation/pages/auth/auth.i18n.dart';
import 'package:davidocs/presentation/pages/auth/providers/get_signin/get_signin_provider.dart';
import 'package:davidocs/presentation/pages/auth/providers/remember.provider.dart';
import 'package:davidocs/presentation/pages/auth/providers/validation.provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:davidocs/presentation/widgets/button.widget.dart';
import 'package:davidocs/presentation/widgets/clipper_top_login.widget.dart';
import 'package:davidocs/presentation/widgets/textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthPhoneview extends ConsumerStatefulWidget {
  const AuthPhoneview({super.key});

  @override
  AuthPhoneviewState createState() => AuthPhoneviewState();
}

class AuthPhoneviewState extends ConsumerState<AuthPhoneview> {
  //Controllers
  final user = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    user.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActiveRemember = ref.watch(rememberProvider);
    final isVisivilityValidationUser = ref.watch(visibilityValidationUser);
    final isVisibilityValidationPassword =
        ref.watch(visibilityValidationPassword);
    final state = ref.watch(signinNotifierProvider);
    ref.listen(
      signinNotifierProvider.select((value) => value),
      ((previous, next) {
        next.whenOrNull(
          data: (responseSigninEntity) =>
              ref.read(appRouterProvider).pushNamed('welcome'),
        );
      }),
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                  children: [
                    //User
                    TextfieldWidget(
                      controller: user,
                      inputType: TextInputType.text,
                      isPassword: false,
                      hint: kHintUser.i18n,
                      hasIcon: true,
                      icon: Icons.person_outline,
                      maxLength: 15,
                      onChanged: (value) {
                        if (value.trim() == '') {
                          ref
                              .read(visibilityValidationUser.notifier)
                              .update((state) => true);
                        } else {
                          ref
                              .read(visibilityValidationUser.notifier)
                              .update((state) => false);
                        }
                        ref
                            .read(userProvider.notifier)
                            .update((state) => value);
                      },
                    ),
                    //Text error
                    Visibility(
                        visible: isVisivilityValidationUser,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              kFieldRequired.i18n,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                          ),
                        )),
                    //Padding
                    Visibility(
                      visible: !isVisivilityValidationUser,
                      child: const SizedBox(
                        height: 16,
                      ),
                    ),
                    //Password
                    TextfieldWidget(
                      controller: password,
                      inputType: TextInputType.emailAddress,
                      isPassword: true,
                      hint: kHintPassword.i18n,
                      hasIcon: true,
                      icon: Icons.lock_outlined,
                      maxLength: 25,
                      onChanged: (value) {
                        if (value.trim() == '') {
                          ref
                              .read(visibilityValidationPassword.notifier)
                              .update((state) => true);
                        } else {
                          ref
                              .read(visibilityValidationPassword.notifier)
                              .update((state) => false);
                        }
                        ref
                            .read(passwordProvider.notifier)
                            .update((state) => value);
                      },
                    ),
                    //Text error
                    Visibility(
                        visible: isVisibilityValidationPassword,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              kFieldRequired.i18n,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                          ),
                        )),
                    //Remember me
                    Row(
                      children: [
                        Checkbox(
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            value: isActiveRemember,
                            onChanged: (newValue) {
                              ref
                                  .read(rememberProvider.notifier)
                                  .update((state) => !state);
                            }),
                        Text(kRemember.i18n)
                      ],
                    ),
                    //power by
                    Image.asset(
                      "assets/images/poweredbyv3.png",
                      height: 50,
                    ),
                    state.maybeWhen(
                      orElse: () => const SizedBox.shrink(),
                      error: (message) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            message ?? 'Error desconocido',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                  child: state.maybeMap(
                orElse: () => ButtonWidget(
                  text: kSignIn.i18n,
                  isPrimary: true,
                  onButtonClick: (isVisibilityValidationPassword == true ||
                          isVisivilityValidationUser == true)
                      ? null
                      : () {
                          ref
                              .read(signinNotifierProvider.notifier)
                              .getSignin(user.text, password.text);
                          // '41521195', "415211952023"
                        },
                ),
                loading: (value) => ElevatedButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    elevation: 0,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: LoadingAnimationWidget.prograssiveDots(
                      color: Theme.of(context).colorScheme.primary, size: 36),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
