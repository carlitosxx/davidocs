import 'dart:async';

import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:davidocs/presentation/pages/home/providers/search_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:davidocs/presentation/widgets/textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentPhoneView extends ConsumerStatefulWidget {
  const DocumentPhoneView({super.key});

  @override
  DocumentPhoneViewState createState() => DocumentPhoneViewState();
}

class DocumentPhoneViewState extends ConsumerState<DocumentPhoneView> {
  final search = TextEditingController();
  Timer? _debounce;

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (search.text.isEmpty) {
        ref.read(isSearchDocumentProvider.notifier).update((state) => false);
      } else {
        setState(() {});
        ref.read(isSearchDocumentProvider.notifier).update((state) => true);
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
    final documentTypeState = ref.watch(listDocumentsProvider);
    final isVisibleFilter = ref.watch(isSearchDocumentProvider);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(kDocumentsTitle.i18n),
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
              loading: () => const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              data: (responseListDocumentsEntity) {
                if (isVisibleFilter) {
                  final filter = responseListDocumentsEntity.datos
                      .where(
                        (element) =>
                            element.detalledocumento.toLowerCase().contains(
                                  search.text.toLowerCase(),
                                ) ||
                            element.periodo
                                .toLowerCase()
                                .contains(search.text.toLowerCase()),
                      )
                      .toList();
                  return SliverList.builder(
                    itemCount: filter.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () {
                            ref
                                .read(documentDetailProvider.notifier)
                                .getDocumentDetailUC(
                                    filter[index].codigodocumento);
                            ref
                                .read(appRouterProvider)
                                .pushNamed('document_detail');
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                    filter[index]
                                                        .detalledocumento,
                                                    softWrap: true,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    filter[index].periodo,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      int.parse(filter[index].totaldescargas) >
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        ' ${kDownloads.i18n} ${filter[index].totaldescargas}'),
                                    Text(filter[index].historicoEnt)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return SliverList.builder(
                    itemCount: responseListDocumentsEntity.numdocumentos,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(documentDetailProvider.notifier)
                              .getDocumentDetailUC(responseListDocumentsEntity
                                  .datos[index].codigodocumento);
                          ref
                              .read(appRouterProvider)
                              .pushNamed('document_detail');
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                      .datos[index]
                                                      .detalledocumento,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                  );
                }
              },
              error: (message) => SliverToBoxAdapter(
                child: Text(message ?? 'desconocido'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
