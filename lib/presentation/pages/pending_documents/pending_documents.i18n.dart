import 'package:i18n_extension/i18n_extension.dart';

// const kBrand = 'kBrand';
const kTitle = 'kTitle';
const kSearchDocument = 'kSearchDocument';
const kResults = 'kResults';

extension PendingDocumentsStrings on String {
  static const _t = Translations.from("en_us", {
    kTitle: {
      "en_us": "Pending documents",
      "es_es": "Pendientes de firma",
    },
    kSearchDocument: {
      "en_us": "Seach document",
      "es_es": "Buscar documento",
    },
    kResults: {
      "en_us": "Results",
      "es_es": "Resultados",
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
