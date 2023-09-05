import 'package:i18n_extension/i18n_extension.dart';

const kBrand = 'kBrand';
const kHome = 'kHome';
const kBusiness = 'kBusiness';
const kDocuments = 'kDocuments';
const kDocumentsType = 'kDocumentsType';
const kDocumentsTitle = 'kDocumentsTitle';
const kDocumentDetail = 'kDocumentDetail';
const kDetailOfSign = 'kDetailOfSign';
const kDetailSign = 'kDetailSign';
const kDownload = 'kDownload';
const kDownloads = 'kDownloads';
const kMessageDetailDocument = 'kMessageDetailDocument';
const kLogout = 'kLogout';
const kProfile = 'kProfile';
const kNotification = 'kNotification';
const kPendingSign = 'kPendingSign';
const kFilterDocument = 'kFilterDocument';
const kDocumentsPendingMessage = 'kDocumentsPendingMessage';
const kDoYouHaveDocument = 'kDoYouHaveDocument';
const kMessageNotification = 'kMessageNotification';
const kAvailableFrom = 'kAvailableFrom';
const kTheBusiness = 'kTheBusiness';
const kSend = 'kSend';
const kCorrespondingTo = 'kCorrespondingTo';
const kOpen = 'kOpen';
const kDownloadedFile = 'kDownloadedFile';

extension HomeStrings on String {
  static const _t = Translations.from("en_us", {
    kOpen: {
      "en_us": "Open",
      "es_es": "Abrir",
    },
    kDownloadedFile: {
      "en_us": "",
      "es_es": "Se descargó el archivo %s",
    },
    kBrand: {
      "en_us": "Davidocs",
      "es_es": "Davidocs",
    },
    kHome: {
      "en_us": "Home",
      "es_es": "Inicio",
    },
    kBusiness: {
      "en_us": "Business:",
      "es_es": "Empresa:",
    },
    kDocuments: {
      "en_us": "Documents:",
      "es_es": "Documentos:",
    },
    kDocumentsType: {
      "en_us": "Documents type",
      "es_es": "Tipo de Documentos",
    },
    kDocumentsTitle: {
      "en_us": "Documents",
      "es_es": "Documentos",
    },
    kDocumentDetail: {
      "en_us": "Document detail",
      "es_es": "Detalle de Documento",
    },
    kDetailSign: {
      "en_us": "Detail sign",
      "es_es": "Detalle firma",
    },
    kDetailOfSign: {
      "en_us": "Detail sign",
      "es_es": "Detalle de firma",
    },
    kDownload: {
      "en_us": "Download",
      "es_es": "Descargar",
    },
    kDownloads: {
      "en_us": "Downloads",
      "es_es": "Descargas",
    },
    kMessageDetailDocument: {
      "en_us": "To view the full document, proceed to download it.",
      "es_es": "Para ver el documento completo proceda a descargarlo",
    },
    kLogout: {
      "en_us": "Logout",
      "es_es": "Cerrar sesión",
    },
    kProfile: {
      "en_us": "Profile",
      "es_es": "Perfil",
    },
    kNotification: {
      "en_us": "Notification",
      "es_es": "Notificacion",
    },
    kPendingSign: {
      "en_us": "Pending Sign",
      "es_es": "Pendientes de firma",
    },
    kFilterDocument: {
      "en_us": "Filter document",
      "es_es": "Filtrar documento",
    },
    kDocumentsPendingMessage: {
      "en_us": "You have documents pending signature: ",
      "es_es": "Usted tiene documentos pendientes de firma: ",
    },
    kDoYouHaveDocument: {
      "en_us": "Do you have a new electronic document.",
      "es_es": "Tiene un nuevo documento electronico.",
    },
    kMessageNotification: {
      "en_us": "Do you have a new electronic document. ",
      "es_es": "La empresa %s le envió su %s, correspondiente al periodo %s.",
    },
    kAvailableFrom: {
      "en_us": "Do you have a new electronic document. ",
      "es_es": "Disponible desde el ",
    },
    kTheBusiness: {
      "en_us": "The business ",
      "es_es": "La Empresa ",
    },
    kSend: {
      "en_us": "he sent his ",
      "es_es": " le envió su ",
    },
    kCorrespondingTo: {
      "en_us": "corresponding to the period",
      "es_es": ", correspondiente al periodo ",
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
