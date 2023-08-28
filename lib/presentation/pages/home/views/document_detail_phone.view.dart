import 'dart:convert';
import 'dart:io';

import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:davidocs/presentation/pages/home/providers/injects_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentDetailPhoneView extends ConsumerWidget {
  const DocumentDetailPhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentDetailState = ref.watch(documentDetailProvider);
    final downloadState = ref.watch(downloadProvider);
    ref.listen(
      downloadProvider.select((value) => value),
      ((prev, next) {
        next.whenOrNull(
          data: (downloadEntity) async {
            Directory? directory = Platform.isAndroid
                ? await getExternalStorageDirectory()
                : await getApplicationDocumentsDirectory();

            String path = "";
            String download =
                Platform.isAndroid ? "/../../../../Davidocs" : "/Files";

            if (directory != null) path = '${directory.path}$download';
            bool exist = await Directory(path).exists();
            if (!exist) {
              await Directory(path).create(recursive: true);
            }
            String imageb64 = downloadEntity.datos.documento.contenidodocumento
                .replaceAll('\n', '');
            Uint8List bytes = base64.decode(imageb64);
            File file =
                File("$path/${downloadEntity.datos.documento.filename}");
            await file.writeAsBytes(bytes.buffer.asInt8List());

            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Se descargó el archivo ${downloadEntity.datos.documento.filename}",
                      softWrap: true,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        OpenFile.open(
                            "$path/${downloadEntity.datos.documento.filename}");
                      },
                      child: Text("ABRIR"))
                ],
              ),
            ));
          },
        );
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
                    onPressed: () async {
                      try {
                        if (!await Permission.storage.request().isGranted) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Debe activar los permisos de Storage",
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        if (Platform.isAndroid) {
                          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                          AndroidDeviceInfo androidInfo =
                              await deviceInfo.androidInfo;
                          if ((androidInfo.version.sdkInt) > 29) {
                            if (!await Permission.manageExternalStorage
                                .request()
                                .isGranted) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Debe activar los permisos de Storage",
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Ocurrio un error",
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
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
