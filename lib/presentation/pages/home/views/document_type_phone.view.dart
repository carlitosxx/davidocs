import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentTypePhoneView extends ConsumerWidget {
  const DocumentTypePhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentTypeState = ref.watch(listDocumentsTypeProvider);
    ref.listen(
      listDocumentsTypeProvider.select((value) => value),
      ((previous, next) {
        next.whenOrNull(
          error: (message) {
            if (message == 'No estas autorizado') {
              ref.read(appRouterProvider).goNamed('auth');
            }
          },
        );
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(kDocumentsType.i18n),
      ),
      body: CustomScrollView(
        slivers: [
          documentTypeState.maybeWhen(
            orElse: () => const SliverToBoxAdapter(
              child: Text('orElse'),
            ),
            data: (responseListDocumentTypeEntity) => SliverList.builder(
              itemCount: responseListDocumentTypeEntity.datos.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    ref.read(listDocumentsProvider.notifier).getListDocumentsUC(
                        responseListDocumentTypeEntity
                            .datos[index].codigoempresa,
                        responseListDocumentTypeEntity
                            .datos[index].codigotipodocumento);
                    ref.read(appRouterProvider).pushNamed('document');
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
                                'assets/images/folder.png',
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
                                      responseListDocumentTypeEntity
                                          .datos[index].nombre,
                                      softWrap: true,
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
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                                ' ${kDocuments.i18n} ${responseListDocumentTypeEntity.datos[index].totaldocumentos}'),
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
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            error: (message) => SliverToBoxAdapter(
              child: Center(child: Text(message ?? 'desconocido')),
            ),
          ),
        ],
      ),
    );
  }
}
