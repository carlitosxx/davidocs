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
                    hint: kSearchDocument.i18n,
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
              SliverList.builder(
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
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
                          ],
                        ),
                        const Divider(),
                        Text('asdasd123')
                      ],
                    ),
                  );
                },
                itemCount: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
