import 'package:i18n_extension/i18n_extension.dart';

// const kBrand = 'kBrand';
const kTitle = 'kTitle';
const kFilterDocument = 'kFilterDocument';
const kResults = 'kResults';
const kDocumentPreview = 'kDocumentPreview';
const kSign = 'kSign';
const kReject = 'kReject';
//showdialog
const kTitleShowDialog = 'kTitleShowDialog';
const kMessageShowDialog = 'kMessageShowDialog';
const kClose = 'kClose';
const kHintEnterPin = 'kHintEnterPin';
const kTitleShowDialogReject = 'kTitleShowDialogReject';
const kReason = 'kReason';
const kReasonDetail = 'kReasonDetail';

extension PendingDocumentsStrings on String {
  static const _t = Translations.from("en_us", {
    kTitle: {
      "en_us": "Pending documents",
      "es_es": "Pendientes de firma",
    },
    kFilterDocument: {
      "en_us": "Filter document",
      "es_es": "Filtrar documento",
    },
    kResults: {
      "en_us": "Results",
      "es_es": "Resultados",
    },
    kDocumentPreview: {
      "en_us": "Document preview",
      "es_es": "Vista previa",
    },
    kSign: {
      "en_us": "Sign",
      "es_es": "Firmar",
    },
    kReject: {
      "en_us": "Reject",
      "es_es": "Rechazar",
    },
    // Show Dialogs
    kTitleShowDialog: {
      "en_us": "Send PIN code",
      "es_es": "Envio de codigo PIN",
    },
    kMessageShowDialog: {
      "en_us": "Reject",
      "es_es":
          "Se ha enviado un mensaje a su correo: %s y al celular %s al ingresar el PIN que se le envió, dará por aceptado y firmado el documento",
    },
    kClose: {
      "en_us": "Close",
      "es_es": "Cerrar",
    },
    kHintEnterPin: {
      "en_us": "Enter your PIN",
      "es_es": "Ingrese el PIN",
    },
    kTitleShowDialogReject: {
      "en_us": "Reject document",
      "es_es": "Rechazar documento",
    },
    kReason: {
      "en_us": "Reason:",
      "es_es": "Motivo:",
    },
    kReasonDetail: {
      "en_us": "Describe the reason",
      "es_es": "Describe el motivo",
    }
  });

  /// Getter to translate the string
  String get i18n => localize(this, _t);

  /// Method for interpolating strings
  String fill(List<Object> params) => localizeFill(this, params);

  /// Method for pluralizing strings
  String plural(int value) => localizePlural(value, this, _t);

  /// Method for creating custom modifiers according to any conditions
  String version(Object modifier) => localizeVersion(modifier, this, _t);

  /// Method for retrieving all the custom modifiers
  Map<String?, String> allVersions() => localizeAllVersions(this, _t);
}
