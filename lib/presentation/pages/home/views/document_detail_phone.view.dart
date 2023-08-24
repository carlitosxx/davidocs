import 'dart:convert';

import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentDetailPhoneView extends ConsumerWidget {
  const DocumentDetailPhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentDetailState = ref.watch(documentDetailProvider);
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
        data: (documentDetailEntity) => Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Container(
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
                  OutlinedButton(onPressed: () {}, child: Text(kDownload.i18n)),
                ],
              )
            ],
          ),
        ),
        error: (message) => Text(message ?? 'error desconocido'),
      ),
    );
  }
}
