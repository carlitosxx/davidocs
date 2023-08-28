import 'dart:async';

import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:davidocs/presentation/pages/home/providers/search_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:davidocs/presentation/widgets/textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentTypePhoneView extends ConsumerStatefulWidget {
  const DocumentTypePhoneView({super.key});

  @override
  DocumentTypePhoneViewState createState() => DocumentTypePhoneViewState();
}

class DocumentTypePhoneViewState extends ConsumerState<DocumentTypePhoneView> {
  final search = TextEditingController();
  Timer? _debounce;

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (search.text.isEmpty) {
        ref
            .read(isSearchDocumentTypeProvider.notifier)
            .update((state) => false);
      } else {
        setState(() {});
        ref.read(isSearchDocumentTypeProvider.notifier).update((state) => true);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documentTypeState = ref.watch(listDocumentsTypeProvider);
    final isVisibleFilter = ref.watch(isSearchDocumentTypeProvider);
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(kDocumentsType.i18n),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverToBoxAdapter(
                child: TextfieldWidget(
                  controller: search,
                  inputType: TextInputType.text,
                  hint: kFilterDocument.i18n,
                  isPassword: false,
                  hasIcon: true,
                  icon: Icons.search,
                  onChanged: _onSearchChanged,
                ),
              ),
            ),
            documentTypeState.maybeWhen(
              orElse: () => const SliverToBoxAdapter(
                child: Text('orElse'),
              ),
              data: (responseListDocumentTypeEntity) => isVisibleFilter
                  ? SliverList.builder(
                      itemCount: responseListDocumentTypeEntity.datos
                          .where(
                            (document) => document.nombre
                                .toLowerCase()
                                .contains(search.text.toLowerCase()),
                          )
                          .length,
                      itemBuilder: (context, index) {
                        final filtered = responseListDocumentTypeEntity.datos
                            .where(
                              (document) => document.nombre
                                  .toLowerCase()
                                  .contains(search.text.toLowerCase()),
                            )
                            .toList();

                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(listDocumentsProvider.notifier)
                                  .getListDocumentsUC(
                                      filtered[index].codigoempresa,
                                      filtered[index].codigotipodocumento);
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
                                  ),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                filtered[index].nombre,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          ' ${kDocuments.i18n} ${filtered[index].totaldocumentos}'),
                                      Icon(
                                        Icons.description_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : SliverList.builder(
                      itemCount: responseListDocumentTypeEntity.datos.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () {
                            ref
                                .read(listDocumentsProvider.notifier)
                                .getListDocumentsUC(
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
                                ),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        ' ${kDocuments.i18n} ${responseListDocumentTypeEntity.datos[index].totaldocumentos}'),
                                    Icon(
                                      Icons.description_outlined,
                                      color:
                                          Theme.of(context).colorScheme.outline,
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
      ),
    );
  }
}
