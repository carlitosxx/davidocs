import 'dart:convert';
import 'dart:typed_data';

import 'package:davidocs/presentation/pages/pending_documents/pending_documents.i18n.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_documents_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:pdfx/pdfx.dart';

class PendingDocumentPhoneView extends ConsumerWidget {
  const PendingDocumentPhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingDocumentState = ref.watch(pendingDocumentNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(kDocumentPreview.i18n),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: pendingDocumentState.maybeWhen(
              orElse: () => const Text('no encontrado'),
              data: (value) {
                Uint8List pdf = base64.decode(value.datos.documento.docPrevio);

                // final pdfController = PdfController(
                //   document: PdfDocument.openData(pdf),
                // );

                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SfPdfViewer.memory(pdf)
                    // PdfView(
                    //   controller: pdfController,
                    //   renderer: (PdfPage page) => page.render(
                    //     width: page.width * 2,
                    //     height: page.height * 2,
                    //     format: PdfPageImageFormat.jpeg,
                    //     backgroundColor: '#FFFFFF',
                    //   ),
                    // )
                    //     PDFView(
                    //   pdfData: pdf,

                    //   // enableSwipe: true,
                    //   swipeHorizontal: true,
                    //   autoSpacing: true,
                    //   pageFling: true,
                    //   pageSnap: true,
                    //   // fitEachPage: true,
                    //   onRender: (int? pages) {
                    //     // provider.totalPage(pages);
                    //   },
                    //   onError: (error) {
                    //     print(error.toString());
                    //   },
                    //   onPageError: (page, error) {
                    //     print('$page: ${error.toString()}');
                    //   },
                    //   onViewCreated: (PDFViewController pdfViewController) {
                    //     print("onViewCreated");
                    //   },
                    //   onPageChanged: (int? page, int? total) {
                    //     // provider.changePage(page, total);
                    //   },
                    // ),
                    );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: Text(kSign.i18n)),
            const SizedBox(
              width: 16,
            ),
            OutlinedButton(onPressed: () {}, child: Text(kReject.i18n)),
          ],
        ),
      ),
    );
  }
}
