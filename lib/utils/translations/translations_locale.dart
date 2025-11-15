// you can put the linguistic locales here

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en_US": en_US,
    "hi": hi,
  };
}

final Map<String, String> en_US = {

  "Basic Information":"Basic Information",

};
final Map<String, String> hi = {
  "Basic Information": "मूल जानकारी",

};
