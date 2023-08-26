import 'dart:convert';

import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DocumentDetailPhoneView extends ConsumerWidget {
  const DocumentDetailPhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentDetailState = ref.watch(documentDetailProvider);
    final downloadState = ref.watch(downloadProvider);
    ref.listen(
      downloadProvider.select((value) => value),
      ((prev, next) {
        next.whenOrNull(data: (downloadEntity) {
          print(downloadEntity.datos.documento.filename);
        });
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(kDocumentDetail.i18n),
      ),
      body: documentDetailState.maybeWhen(
        orElse: () => const Text('orElse'),
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: CircularProgressIndicator(),
          ),
        ),
        data: (documentDetailEntity) => Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: const Color(0xffdeebf7),
              child: Text(
                kMessageDetailDocument.i18n,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xff7f7f7f)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
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
                child: InteractiveViewer(
                  child: Image.memory(base64Decode(
                      documentDetailEntity.datos.documento.imgPrevia)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      ref.read(appRouterProvider).pushNamed('detail_sign');
                    },
                    child: Text(kDetailSign.i18n)),
                const SizedBox(
                  width: 16,
                ),
                downloadState.maybeWhen(
                  orElse: () => OutlinedButton(
                    onPressed: () {
                      ref.read(downloadProvider.notifier).getDownloadFile(
                          documentDetailEntity.datos.documento.codigodocumento);
                    },
                    child: Text(kDownload.i18n),
                  ),
                  loading: () => OutlinedButton(
                    onPressed: null,
                    child: LoadingAnimationWidget.prograssiveDots(
                        color: Theme.of(context).colorScheme.primary, size: 36),
                  ),
                ),
              ],
            )
          ],
        ),
        error: (message) => Text(message ?? 'error desconocido'),
      ),
    );
  }
}
