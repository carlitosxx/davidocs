import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentTypePhoneView extends ConsumerWidget {
  const DocumentTypePhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentTypeState = ref.watch(listDocumentsTypeProvider);
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
              itemBuilder: (context, index) => Text('asasd'),
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
              child: Text(message ?? 'desconocido'),
            ),
          ),
        ],
      ),
    );
  }
}
