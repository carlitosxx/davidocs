import 'package:i18n_extension/i18n_extension.dart';

const kWelcome = 'kBrand';
const kNext = 'kNext';
const kFullname = 'kFullname';
const kDNI = 'kDNI';
const kEmail = 'kEmail';
const kPhone = 'kPhone';

extension WelcomeStrings on String {
  static const _t = Translations.from("en_us", {
    kWelcome: {
      "en_us": "Welcome",
      "es_es": "Bienvenido",
    },
    kNext: {
      "en_us": "Next",
      "es_es": "Siguiente",
    },
    kFullname: {
      "en_us": "Fullname",
      "es_es": "Nombre completo",
    },
    kDNI: {
      "en_us": "DNI",
      "es_es": "DNI",
    },
    kEmail: {
      "en_us": "Email",
      "es_es": "Correo",
    },
    kPhone: {
      "en_us": "Phone",
      "es_es": "Telefono",
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
