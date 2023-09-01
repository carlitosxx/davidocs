import 'dart:convert';
import 'dart:io';

import 'package:davidocs/presentation/pages/auth/providers/get_signin/get_signin_provider.dart';
import 'package:davidocs/presentation/pages/pending_documents/pending_documents.i18n.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/document_provider.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_documents_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dart_ipify/dart_ipify.dart';

class PendingDocumentPhoneView extends ConsumerStatefulWidget {
  const PendingDocumentPhoneView({super.key, required this.documentID});
  final String documentID;

  @override
  PendingDocumentPhoneViewState createState() =>
      PendingDocumentPhoneViewState();
}

class PendingDocumentPhoneViewState
    extends ConsumerState<PendingDocumentPhoneView> {
  String ipPublic = '';
  final TextEditingController reason = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadIpv4();
  }

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }

  loadIpv4() async {
    final ipv4 = await Ipify.ipv4();
    ipPublic = ipv4;
  }

  @override
  Widget build(BuildContext context) {
    final isLoadingButtonReject = ref.watch(isLoadingProvider);
    final pendingDocumentState = ref.watch(pendingDocumentNotifierProvider);
    final sendPendingDocumentState =
        ref.watch(sendPendingDocumentNotifierProvider);

    ref.listen(rejectNotifierProvider.select((value) => value), ((prev, next) {
      next.whenOrNull(data: (responseRejectEntity) {
        ref.read(appRouterProvider).pop();
        ref.read(appRouterProvider).goNamed('home');
      });
    }));
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
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SfPdfViewer.memory(pdf));
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sendPendingDocumentState.maybeMap(
              orElse: () => ElevatedButton(
                onPressed: () async {
                  ref
                      .read(sendPendingDocumentNotifierProvider.notifier)
                      .sendDocumentPending(widget.documentID);
                  LocationPermission permission;

                  bool serviceEnabled =
                      await Geolocator.isLocationServiceEnabled();
                  if (!serviceEnabled) {
                    // throw GenericTextException("Error: El servicio de ubicacion esta desabilitado");
                  }

                  permission = await Geolocator.checkPermission();

                  if (permission == LocationPermission.denied ||
                      permission == LocationPermission.deniedForever) {
                    permission = await Geolocator.requestPermission();

                    if (permission == LocationPermission.denied ||
                        permission == LocationPermission.deniedForever) {
                      // throw GenericTextException("Error: Debe activar los permisos de ubicación");
                    }
                  }
                  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                  String network = '';
                  for (var interface in await NetworkInterface.list()) {
                    network += '== Interface: ${interface.name} ==';
                    for (var addr in interface.addresses) {
                      network +=
                          "<${addr.address}|${addr.host}|${addr.isLoopback}|${addr.type.name}>";
                    }
                  }

                  final androidDeviceInfo = await deviceInfo.androidInfo;
                  final String information =
                      "App DaviDocs versión 2.0 con sistema operativo [ Android ${androidDeviceInfo.version.release} API Level ${androidDeviceInfo.version.sdkInt}] - IpPublica [$ipPublic] - RedLocal [$network] Mac: [unknown] Model: ${androidDeviceInfo.model}";

                  // ignore: use_build_context_synchronously
                  _dialogSignBuilder(context, ref, information);
                },
                child: Text(kSign.i18n),
              ),
              loading: (value) => ElevatedButton(
                onPressed: null,
                child: LoadingAnimationWidget.prograssiveDots(
                    color: Theme.of(context).colorScheme.primary, size: 36),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            OutlinedButton(
              onPressed: () async {
                //* asdasdasd
                ref.read(isLoadingProvider.notifier).update((state) => false);
                LocationPermission permission;

                bool serviceEnabled =
                    await Geolocator.isLocationServiceEnabled();
                if (!serviceEnabled) {
                  // throw GenericTextException("Error: El servicio de ubicacion esta desabilitado");
                }

                permission = await Geolocator.checkPermission();

                if (permission == LocationPermission.denied ||
                    permission == LocationPermission.deniedForever) {
                  permission = await Geolocator.requestPermission();

                  if (permission == LocationPermission.denied ||
                      permission == LocationPermission.deniedForever) {
                    // throw GenericTextException("Error: Debe activar los permisos de ubicación");
                  }
                } else {
                  final location = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                  String network = '';
                  for (var interface in await NetworkInterface.list()) {
                    network += '== Interface: ${interface.name} ==';
                    for (var addr in interface.addresses) {
                      network +=
                          "<${addr.address}|${addr.host}|${addr.isLoopback}|${addr.type.name}>";
                    }
                  }

                  final androidDeviceInfo = await deviceInfo.androidInfo;
                  final String information =
                      "App DaviDocs versión 2.0 con sistema operativo [ Android ${androidDeviceInfo.version.release} API Level ${androidDeviceInfo.version.sdkInt}] - IpPublica [$ipPublic] - RedLocal [$network] Mac: [unknown] Model: ${androidDeviceInfo.model}";
                  ref.read(isLoadingProvider.notifier).update((state) => true);
// ignore: use_build_context_synchronously
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Consumer(builder: (BuildContext context,
                          WidgetRef widgetRef, Widget? child) {
                        final state = widgetRef.watch(rejectNotifierProvider);
                        return AlertDialog(
                          title: Text(kTitleShowDialogReject.i18n,
                              textAlign: TextAlign.center),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kReason.i18n,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(.1),
                                ),
                                child: TextField(
                                  controller: reason,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: InputBorder.none,
                                    hintText: kReasonDetail.i18n,
                                    hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                ),
                              ),
                              state.maybeWhen(
                                orElse: () => const SizedBox.shrink(),
                                error: (value) => Text(
                                    value ?? 'ocurrio un error desconocido',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error)),
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: Text(kClose.i18n),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            state.maybeMap(
                              orElse: () => ElevatedButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: Text(kReject.i18n),
                                onPressed: () {
                                  ref
                                      .read(rejectNotifierProvider.notifier)
                                      .rejectDocument(
                                          widget.documentID,
                                          reason.text,
                                          information,
                                          location.latitude.toString(),
                                          location.longitude.toString());
                                },
                              ),
                              loading: (v) => ElevatedButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                onPressed: null,
                                child: LoadingAnimationWidget.prograssiveDots(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 36),
                              ),
                            )
                          ],
                        );
                      });
                    },
                  );
                }
              },
              child: isLoadingButtonReject
                  ? Text(kReject.i18n)
                  : LoadingAnimationWidget.prograssiveDots(
                      color: Theme.of(context).colorScheme.primary, size: 36),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _dialogSignBuilder(
    BuildContext context, WidgetRef ref, String information) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final user = ref.watch(signinNotifierProvider);
      final String email = user.whenOrNull(
            data: (responseSigninEntity) => responseSigninEntity.correo,
          ) ??
          '';
      final String phoneNumber = user.whenOrNull(
            data: (responseSigninEntity) => responseSigninEntity.celular,
          ) ??
          '';
      return AlertDialog(
        title: Text(kTitleShowDialog.i18n, textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              kMessageShowDialog.i18n.fill([email, phoneNumber]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.1),
                ),
                child: TextField(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: kHintEnterPin.i18n,
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.3),
                    ),
                  ),
                ))
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(kClose.i18n),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(kSign.i18n),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// Future<void> _dialogRejectBuilder(
//     BuildContext context, WidgetRef ref, String information) {
//   return 
// }
