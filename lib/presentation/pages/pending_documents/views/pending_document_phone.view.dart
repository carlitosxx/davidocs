import 'dart:convert';

import 'package:davidocs/presentation/pages/auth/providers/get_signin/get_signin_provider.dart';
import 'package:davidocs/presentation/pages/pending_documents/pending_documents.i18n.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_documents_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:mac_address/mac_address.dart';

class PendingDocumentPhoneView extends ConsumerStatefulWidget {
  const PendingDocumentPhoneView({super.key, required this.documentID});
  final String documentID;

  @override
  PendingDocumentPhoneViewState createState() =>
      PendingDocumentPhoneViewState();
}

class PendingDocumentPhoneViewState
    extends ConsumerState<PendingDocumentPhoneView> {
  String _platformVersion = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    print(platformVersion);
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pendingDocumentState = ref.watch(pendingDocumentNotifierProvider);
    final sendPendingDocumentState =
        ref.watch(sendPendingDocumentNotifierProvider);

    ref.listen(
      sendPendingDocumentNotifierProvider.select((value) => value),
      ((prev, next) {
        next.whenOrNull(
            data: (responseSendDocumentPendingEntity) =>
                print(responseSendDocumentPendingEntity.codigotoken));
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(_platformVersion),
        // Text(kDocumentPreview.i18n),
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
                onPressed: () {
                  ref
                      .read(sendPendingDocumentNotifierProvider.notifier)
                      .sendDocumentPending(widget.documentID);
                  _dialogSignBuilder(context, ref);
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

                _dialogRejectBuilder(context, ref);
              },
              child: Text(kReject.i18n),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _dialogSignBuilder(BuildContext context, WidgetRef ref) {
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

Future<void> _dialogRejectBuilder(BuildContext context, WidgetRef ref) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      // final user = ref.watch(signinNotifierProvider);
      // final String email = user.whenOrNull(
      //       data: (responseSigninEntity) => responseSigninEntity.correo,
      //     ) ??
      //     '';
      // final String phoneNumber = user.whenOrNull(
      //       data: (responseSigninEntity) => responseSigninEntity.celular,
      //     ) ??
      //     '';
      return AlertDialog(
        title: Text(kTitleShowDialogReject.i18n, textAlign: TextAlign.center),
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
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
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
            child: Text(kReject.i18n),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
