import 'package:davidocs/presentation/pages/home/widgets/my_drawer.dart';
import 'package:davidocs/presentation/pages/pending_documents/pending_documents.i18n.dart';
// import 'package:davidocs/presentation/pages/pending_documents/providers/document_selected.provider.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_documents_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:davidocs/presentation/widgets/textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingDocumentsPhoneView extends ConsumerStatefulWidget {
  const PendingDocumentsPhoneView({super.key});

  @override
  PendingDocumentsPhoneViewState createState() =>
      PendingDocumentsPhoneViewState();
}

class PendingDocumentsPhoneViewState
    extends ConsumerState<PendingDocumentsPhoneView> {
  final search = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pendingDocumentsState = ref.watch(pendingDocumentsNotifierProvider);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(kTitle.i18n),
        ),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 16),
                sliver: SliverToBoxAdapter(
                  child: TextfieldWidget(
                    controller: search,
                    inputType: TextInputType.text,
                    hint: kFilterDocument.i18n,
                    isPassword: false,
                    hasIcon: true,
                    icon: Icons.search,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    kResults.i18n,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              pendingDocumentsState.maybeWhen(
                orElse: () {
                  return const SliverToBoxAdapter(
                      child: Text('ocurrio un error inesperado'));
                },
                error: (message) => SliverToBoxAdapter(
                    child: Text(message ?? 'error desconocido')),
                data: (documentsPending) => SliverList.builder(
                  itemBuilder: (context, index) {
                    final item = documentsPending.datos[index];
                    return GestureDetector(
                      onTap: () {
                        // ref
                        //     .read(documentSelectedProvider.notifier)
                        //     .update((state) => item.codigodocumentopendiente);
                        print(item.codigodocumentopendiente);
                        ref
                            .read(pendingDocumentNotifierProvider.notifier)
                            .getDocumentPendingByID(
                                item.codigodocumentopendiente);
                        ref.read(appRouterProvider).pushNamed(
                            'pending_document',
                            extra: item.codigodocumentopendiente);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        margin: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
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
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/pdf.png',
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.organizacion),
                                    Text(item.tipodocumento),
                                    Text(item.periodo)
                                  ],
                                )
                              ],
                            ),
                            const Divider(),
                            Text(item.detalledocumento)
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: documentsPending.numdocumentos,
                ),
                loading: () => const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
