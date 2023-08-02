import 'package:i18n_extension/i18n_extension.dart';

// const kBrand = 'kBrand';
const kTitle = 'kTitle';
const kFilterDocument = 'kFilterDocument';
const kResults = 'kResults';
const kDocumentPreview = 'kDocumentPreview';

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
