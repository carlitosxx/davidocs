import 'package:davidocs/presentation/pages/home/widgets/my_drawer.dart';
import 'package:davidocs/presentation/pages/pending_documents/pending_documents.i18n.dart';
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
  Widget build(BuildContext context) {
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
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverToBoxAdapter(
                child: TextfieldWidget(
                  controller: search,
                  inputType: TextInputType.text,
                  hint: kSearchDocument.i18n,
                  isPassword: false,
                  hasIcon: true,
                  icon: Icons.search,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  kResults.i18n,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
