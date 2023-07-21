import 'package:davidocs/presentation/pages/auth/auth.i18n.dart';
import 'package:davidocs/presentation/widgets/button.widget.dart';
import 'package:davidocs/presentation/widgets/textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            // backgroundColor: Colors.blue,
            appBar: AppBar(),
            body: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: SizedBox(
                            width: 220,
                            child:
                                Image.asset('assets/images/davidoc_white.png'),
                          ),
                        ),
                        TextfieldWidget(
                          controller: user,
                          inputType: TextInputType.emailAddress,
                          isPassword: false,
                          hint: kHintUser.i18n,
                          hasIcon: true,
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextfieldWidget(
                            controller: password,
                            inputType: TextInputType.emailAddress,
                            isPassword: true,
                            hint: kHintPassword.i18n,
                            hasIcon: true,
                            icon: Icons.lock_outlined),
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  text: kSignIn.i18n,
                  isPrimary: true,
                  onButtonClick: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
