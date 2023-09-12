import 'package:davidocs/presentation/pages/auth/providers/get_signin_provider.dart';
import 'package:davidocs/presentation/pages/home/home.i18n.dart';
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
    final countPendingSign = ref.watch(pendingDocumentsNotifierProvider);
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(appRouterProvider).goNamed('home');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 16, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kHome.i18n,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(Icons.home_outlined)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(appRouterProvider).goNamed('pending_documents');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 16, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kPendingSign.i18n,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(Icons.border_color_outlined),
                              ),
                              Positioned(
                                top: 0,
                                right: 10,
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child:
                                        // Text('0'),
                                        Text(
                                      countPendingSign.maybeWhen(
                                        orElse: () => '0',
                                        data: (value) =>
                                            value.numdocumentos.toString(),
                                      ),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(appRouterProvider).pushNamed('notification');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 16, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kNotification.i18n,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(Icons.notifications_outlined)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(appRouterProvider).pushNamed('welcome');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 16, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kProfile.i18n,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.person_outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Divider(),
                  ListTile(
                    title: Text(
                      kLogout.i18n,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.logout,
                    ),
                    onTap: () {
                      ref.read(loadNotifierProvider.notifier).reset();
                      // ref
                      //     .read(loadNotifierProvider.notifier)
                      //     .loadAccountRemembered();
                      ref.read(appRouterProvider).pushReplacementNamed('auth');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
