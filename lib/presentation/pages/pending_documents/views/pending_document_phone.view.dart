import 'dart:convert';

// import 'package:davidocs/presentation/pages/auth/providers/get_signin/get_signin_provider.dart';
import 'package:davidocs/presentation/pages/pending_documents/pending_documents.i18n.dart';
import 'package:davidocs/presentation/pages/pending_documents/providers/pending_documents_provider.dart';
import 'package:davidocs/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PendingDocumentPhoneView extends ConsumerStatefulWidget {
  const PendingDocumentPhoneView({super.key, required this.documentID});
  final String documentID;

  @override
  PendingDocumentPhoneViewState createState() =>
      PendingDocumentPhoneViewState();
}

class PendingDocumentPhoneViewState
    extends ConsumerState<PendingDocumentPhoneView> {
  Map<String, dynamic> responseGpsSign = {};
  TextEditingController reason = TextEditingController();
  TextEditingController pinOtp = TextEditingController();
  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingDocumentState = ref.watch(pendingDocumentNotifierProvider);
    final sendPendingDocumentState =
        ref.watch(sendPendingDocumentNotifierProvider);
    final gpsState = ref.watch(validateGpsNotifierProvider);
    final gpsSignState = ref.watch(validateGpsSignNotifierProvider);

    /// Rechazar -> state=data
    ref.listen(
      rejectNotifierProvider.select((value) => value),
      ((prev, next) {
        next.whenOrNull(data: (responseRejectEntity) {
          ref.read(appRouterProvider).pop();
          ref
              .read(pendingDocumentsNotifierProvider.notifier)
              .getListDocumentsPending();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Expanded(
                    child: Text(
                      kMessageRefused.i18n,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          );
          ref.read(appRouterProvider).goNamed('home');
        });
      }),
    );

    /// Firmar -> state=data
    ref.listen(
      sendPinNotifierProvider.select((value) => value),
      ((prev, next) {
        next.whenOrNull(data: (responseSendPinEntity) {
          ref.read(appRouterProvider).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Expanded(
                    child: Text(
                      kMessageSignined.i18n,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          );
          ref
              .read(pendingDocumentsNotifierProvider.notifier)
              .getListDocumentsPending();
          ref.read(appRouterProvider).goNamed('home');
        });
      }),
    );

    /// Validar GPS del boton firmar
    ref.listen(
      validateGpsSignNotifierProvider.select((value) => value),
      ((prev, next) {
        next.whenOrNull(
          error: (message) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(kTitleDialogReject.i18n),
                content: Text(message ?? 'error desconocido'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Text(kClose.i18n),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
          data: (response) {
            ref
                .read(sendPendingDocumentNotifierProvider.notifier)
                .sendDocumentPending(widget.documentID);
            responseGpsSign = response;
          },
        );
      }),
    );

    /// Envio de codigo OTP
    ref.listen(
      sendPendingDocumentNotifierProvider.select((value) => value),
      ((prev, next) {
        next.whenOrNull(
          error: (message) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(kTitleDialogReject.i18n),
                content: Text(message ?? 'error desconocido'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Text(kClose.i18n),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
          data: (response) {
            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Consumer(builder:
                    (BuildContext context, WidgetRef widgetRef, Widget? child) {
                  final state = widgetRef.watch(sendPinNotifierProvider);

                  return AlertDialog(
                    title: Text(kTitleShowDialog.i18n,
                        textAlign: TextAlign.center),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          response.datos,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          kMessageShowDialog.i18n,
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
                            controller: pinOtp,
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            maxLength: 6,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                          ),
                        ),
                        state.maybeWhen(
                          orElse: () => const SizedBox.shrink(),
                          error: (value) => Text(
                            value ?? 'ocurrio un error desconocido',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error),
                          ),
                        ),
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
                      state.maybeMap(
                        orElse: () => ElevatedButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: Text(kSign.i18n),
                          onPressed: () {
                            ref.read(sendPinNotifierProvider.notifier).sendPin(
                                  widget.documentID,
                                  response.codigotoken,
                                  pinOtp.text,
                                  responseGpsSign['information'],
                                  responseGpsSign['location']
                                      .latitude
                                      .toString(),
                                  responseGpsSign['location']
                                      .longitude
                                      .toString(),
                                );
                          },
                        ),
                        loading: (v) => ElevatedButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          onPressed: null,
                          child: LoadingAnimationWidget.prograssiveDots(
                              color: Theme.of(context).colorScheme.primary,
                              size: 36),
                        ),
                      )
                    ],
                  );
                });
              },
            );
          },
        );
      }),
    );

    /// Validar Gps del boton rechazar
    ref.listen(
      validateGpsNotifierProvider.select((value) => value),
      ((prev, next) {
        next.whenOrNull(
          error: (message) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(kTitleDialogReject.i18n),
                content: Text(message ?? 'error desconocido'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Text(kClose.i18n),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
          data: (response) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return Consumer(builder:
                  (BuildContext context, WidgetRef widgetRef, Widget? child) {
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
                              color:
                                  Theme.of(context).colorScheme.onBackground),
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
                                color: Theme.of(context).colorScheme.error)),
                      )
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
                    state.maybeMap(
                      orElse: () => ElevatedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: Text(kReject.i18n),
                        onPressed: () {
                          ref
                              .read(rejectNotifierProvider.notifier)
                              .rejectDocument(
                                  widget.documentID,
                                  reason.text,
                                  response['information'],
                                  response['location'].latitude.toString(),
                                  response['location'].longitude.toString());
                        },
                      ),
                      loading: (v) => ElevatedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        onPressed: null,
                        child: LoadingAnimationWidget.prograssiveDots(
                            color: Theme.of(context).colorScheme.primary,
                            size: 36),
                      ),
                    )
                  ],
                );
              });
            },
          ),
        );
      }),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(kDocumentPreview.i18n),
      ),
      body: pendingDocumentState.maybeWhen(
        orElse: () => const Text('no encontrado'),
        data: (value) {
          Uint8List pdf = base64.decode(value.datos.documento.docPrevio);
          return SfPdfViewer.memory(pdf);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// BOTON FIRMAR
            sendPendingDocumentState.maybeWhen(
              orElse: () => gpsSignState.maybeWhen(
                orElse: () => ElevatedButton(
                  onPressed: () {
                    ref
                        .read(validateGpsSignNotifierProvider.notifier)
                        .validateGps();
                  },
                  child: Text(kSign.i18n),
                ),
                loading: () => ElevatedButton(
                  onPressed: null,
                  child: LoadingAnimationWidget.prograssiveDots(
                      color: Theme.of(context).colorScheme.primary, size: 36),
                ),
              ),
              loading: () => ElevatedButton(
                onPressed: null,
                child: LoadingAnimationWidget.prograssiveDots(
                    color: Theme.of(context).colorScheme.primary, size: 36),
              ),
            ),

            const SizedBox(
              width: 16,
            ),

            /// BOTON RECHAZAR
            gpsState.maybeWhen(
              orElse: () => OutlinedButton(
                onPressed: () {
                  ref.read(validateGpsNotifierProvider.notifier).validateGps();
                },
                child: Text(kReject.i18n),
              ),
              loading: () => OutlinedButton(
                onPressed: null,
                child: LoadingAnimationWidget.prograssiveDots(
                    color: Theme.of(context).colorScheme.primary, size: 36),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
