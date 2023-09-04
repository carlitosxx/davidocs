import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationPhoneView extends ConsumerWidget {
  const NotificationPhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNotifications = ref.watch(listNotificationsProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(kNotification.i18n),
        ),
        body: CustomScrollView(
          slivers: [
            listNotifications.maybeWhen(
              orElse: () => const SliverToBoxAdapter(
                child: Text('orElse'),
              ),
              loading: () => const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              error: (message) => SliverToBoxAdapter(
                  child: Text(
                message ?? 'error desconocido',
                textAlign: TextAlign.center,
              )),
              data: (listNotifications) => SliverList.builder(
                itemCount: listNotifications.numnotificaciones,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(documentDetailProvider.notifier)
                          .getDocumentDetailUC(
                              listNotifications.datos[index].codigodocumento);
                      ref.read(appRouterProvider).pushNamed('document_detail');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.2),
                            blurRadius: 2,
                            offset: const Offset(1, 1),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/notificacion.png',
                                  height: 50,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text:
                                                '${kDoYouHaveDocument.i18n}\n',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                            children: [
                                              TextSpan(
                                                text: kTheBusiness.i18n,
                                              ),
                                              TextSpan(
                                                text: listNotifications
                                                    .datos[index].empresa,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: kSend.i18n,
                                              ),
                                              TextSpan(
                                                text: listNotifications
                                                    .datos[index].tipodocumento,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                  text: kCorrespondingTo.i18n),
                                              TextSpan(
                                                text: listNotifications
                                                    .datos[index].periodo,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Text(
                            '${kAvailableFrom.i18n}${listNotifications.datos[index].disponible}',
                            softWrap: true,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
