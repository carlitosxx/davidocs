// import 'package:davicloud/core/l10n/l10n.dart';
import 'package:davidocs/presentation/pages/auth/providers/get_signin/get_signin_provider.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_documents_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signinNotifierProvider);
    return Drawer(
      child: Column(
        children: [
          Flexible(
            flex: 25,
            child: Padding(
              padding: const EdgeInsets.only(top: 55, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage(
                          'assets/images/icono-app.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        signinState.maybeWhen(
                          orElse: () => const Text(''),
                          data: (value) => Text(
                            value.nombre,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        signinState.maybeWhen(
                          orElse: () => const Text(''),
                          data: (value) => Text(
                            value.documento,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          Flexible(
            flex: 65,
            fit: FlexFit.tight,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(appRouterProvider).goNamed('home');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 20),
                    child: Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.home_outlined)),
                        Text(
                          'Inicio',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(appRouterProvider).goNamed('pending_documents');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 20),
                    child: Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.border_color_outlined)),
                        Text(
                          'Pendientes de firma',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 20),
                    child: Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.notifications_outlined)),
                        Text(
                          'Notificacion',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.person_outline,
                          ),
                        ),
                        Text(
                          'Perfil',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 10,
            // fit: FlexFit.tight,
            child: Column(
              children: [
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: Text(
                    'Cerrar sesion',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/company',
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
