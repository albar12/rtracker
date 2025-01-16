import 'package:rtracker/helper/extensions.dart';

class Strings {
  static bool equals(String? value, String? predicate) {
    return (value ?? "") == (predicate ?? "");
  }

  static bool equalsIgnoreCase(String? value, String? predicate) {
    return equals(
      (value ?? "").toLowerCase(),
      (predicate ?? "").toLowerCase(),
    );
  }

  static bool equalsAny(String? value, List<String> predicates) {
    bool result = false;

    for (String predicate in predicates) {
      if (equals(value, predicate)) {
        result = true;

        break;
      }
    }

    return result;
  }

  static bool equalsIgnoreCaseAny(String? value, List<String> predicates) {
    bool result = false;

    for (String predicate in predicates) {
      if (equals((value ?? "").toLowerCase(), predicate.toLowerCase())) {
        result = true;

        break;
      }
    }

    return result;
  }

  static String deBlank(String? value) {
    return value ?? "";
  }

  static String firstWord(String? value) {
    value ??= "";

    return value.contains(' ') ? value.split(' ').first : value;
  }

  static String pretty(String? value) {
    print("alif pretty");
    print(value);

    if (value != 'paper_roll') {
      value ??= "";
      value = value.replaceAll("_", " ");
      value = value.capitalizeFirstLetterOfEachWord();

      return value;
    } else {
      // value ??= "";
      String valuex = "jumlah thermal yang ditemukan di merchant";
      valuex = valuex.capitalizeFirstLetterOfEachWord();

      value ??= "";
      value = value.replaceAll("_", " ");
      value = value.capitalizeFirstLetterOfEachWord();

      return value + " (" + valuex + ")";
    }
  }

  static bool isZero(String value){
    try {
      int parsedNumber = int.parse(value);
      if (parsedNumber == 0){
        return true;
      } else {
        return false;
      }
    } catch (_){
      return false;
    }
  }
}
