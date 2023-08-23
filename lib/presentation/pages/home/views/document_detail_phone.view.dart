import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentDetailPhoneView extends ConsumerWidget {
  const DocumentDetailPhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kDocumentDetail.i18n),
      ),
    );
  }
}
