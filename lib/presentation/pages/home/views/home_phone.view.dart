import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:davidocs/presentation/pages/home/widgets/my_drawer.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_documents_provider.dart';

import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePhoneView extends ConsumerWidget {
  const HomePhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listBusinessState = ref.watch(listBusinessProvider);

    ref.listen(
      pendingDocumentsNotifierProvider.select((value) => value),
      ((prev, next) {
        next.whenOrNull(
          data: (pendingDocuments) async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(kNotification.i18n),
                  content: Text(
                    '${kDocumentsPendingMessage.i18n} ${pendingDocuments.numdocumentos.toString()}',
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('cerrar'),
                      onPressed: () {
                        ref.read(appRouterProvider).pop();
                      },
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('ver'),
                      onPressed: () {
                        ref
                            .read(appRouterProvider)
                            .pushNamed('pending_documents');
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(kHome.i18n),
      ),
      body: CustomScrollView(
        slivers: [
          listBusinessState.maybeWhen(
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
            data: (listBusiness) => SliverList.builder(
              itemCount: listBusiness.numempresas,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    ref
                        .read(listDocumentsTypeProvider.notifier)
                        .getListDocumentType(
                            listBusiness.datos[index].codigoempresa);
                    ref.read(appRouterProvider).pushNamed('document_type');
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
                                'assets/images/company.png',
                                height: 50,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      kBusiness.i18n,
                                    ),
                                    Text(
                                      listBusiness.datos[index].nombre,
                                      // maxLines: 2,
                                      softWrap: true,
                                      // overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                ' ${kDocuments.i18n} ${listBusiness.datos[index].totaldocumentos}'),
                            Icon(
                              Icons.description_outlined,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            error: (message) => SliverToBoxAdapter(
              child: Text(message ?? 'desconocido'),
            ),
          ),
          // SliverList.builder(
          //   itemBuilder: (context, index) => Container(),
          // ),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
