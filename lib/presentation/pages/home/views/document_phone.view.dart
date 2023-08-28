import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentPhoneView extends ConsumerWidget {
  const DocumentPhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentTypeState = ref.watch(listDocumentsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(kDocumentsTitle.i18n),
      ),
      body: CustomScrollView(
        slivers: [
          documentTypeState.maybeWhen(
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
            data: (responseListDocumentsEntity) => SliverList.builder(
              itemCount: responseListDocumentsEntity.numdocumentos,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    ref
                        .read(documentDetailProvider.notifier)
                        .getDocumentDetailUC(responseListDocumentsEntity
                            .datos[index].codigodocumento);
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/pdf.png',
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
                                          Text(
                                            responseListDocumentsEntity
                                                .datos[index].detalledocumento,
                                            softWrap: true,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            responseListDocumentsEntity
                                                .datos[index].periodo,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              int.parse(responseListDocumentsEntity
                                          .datos[index].totaldescargas) >
                                      0
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                ' ${kDownloads.i18n} ${responseListDocumentsEntity.datos[index].totaldescargas}'),
                            Text(responseListDocumentsEntity
                                .datos[index].historicoEnt)
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
          )
        ],
      ),
    );
  }
}
