class IntUtils {
  static int? parseToInt(String? data) {
    try {
      return int.tryParse(data!);
    } catch (e){
      return 0;
    }
  }
}