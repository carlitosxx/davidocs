import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:flutter_html_table/flutter_html_table';
class DetailSignPhoneView extends ConsumerWidget {
  const DetailSignPhoneView({super.key});
  srcMatcher({String? srcCert, String? srcOk}) => (attributes, element) =>
      (attributes["src"]?.endsWith(srcCert ?? "") ?? false) ||
      (attributes["src"]?.endsWith(srcOk ?? "") ?? false);

  srcReplaceRender({String? srcCertToMatch, String? srcOkToMatch}) =>
      (context, attributes, element) {
        if ((attributes["src"]?.endsWith(srcCertToMatch ?? "") ?? false))
          return SvgPicture.asset(
            'assets/images/workspace_premium.svg',
            // color: Colors.green,
          );
        else if ((attributes["src"]?.endsWith(srcOkToMatch ?? "") ?? false)) {
          return Icon(
            Icons.check,
            color: Colors.green,
          );
        } else {
          return Icon(
            Icons.remove,
            color: Colors.grey,
          );
        }
      };
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentDetailState = ref.watch(documentDetailProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalle de firma'),
        ),
        body: documentDetailState.maybeWhen(
            orElse: () => Text('orElse'),
            data: (documentDetailEntity) {
              return SingleChildScrollView(
                child: Html(
                  data: documentDetailEntity.datos.documento.detallefirma,
                  extensions: [
                    const TableHtmlExtension(),
                    TagExtension(
                      tagsToExtend: {"img"},
                      builder: (extensionContext) {
                        if (extensionContext.attributes['src']
                                ?.endsWith('certificado.png') ??
                            false) {
                          return SvgPicture.asset(
                              'assets/images/workspace_premium.svg',
                              colorFilter: const ColorFilter.mode(
                                  Colors.green, BlendMode.srcIn));
                        } else if (extensionContext.attributes['src']
                                ?.endsWith('ok.png') ??
                            false) {
                          return const Icon(
                            Icons.check,
                            color: Colors.green,
                          );
                        } else {
                          return const Icon(
                            Icons.remove,
                            color: Colors.grey,
                          );
                        }
                      },
                    ),
                  ],
                  style: {
                    "table": Style(
                      border: Border.all(color: Colors.grey),
                    ),
                    "th": Style(
                      border: Border.all(color: Colors.grey),
                      padding: HtmlPaddings.symmetric(vertical: 20),
                      height: Height(20),
                    ),
                    "tr": Style(
                      border: Border.all(color: Colors.grey),
                      padding:
                          HtmlPaddings.symmetric(vertical: 5, horizontal: 5),
                      // height: 20.0
                    ),
                    "td": Style(
                      border: Border.all(color: Colors.grey),
                      // padding: EdgeInsets.symmetric(horizontal: 2),
                    ),
                  },
                ),
              );
            }));
  }
}
