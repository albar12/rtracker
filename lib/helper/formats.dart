import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class Formats {
  static String date(DateTime? dateTime) {
    try {
      return DateFormat("dd MMMM yyyy", "id").format(dateTime!.toLocal());
    } catch (e) {
      return "";
    }
  }

  static String dateTime(DateTime? dateTime) {
    try {
      return DateFormat("dd MMMM yyyy HH:mm", "id").format(dateTime!.toLocal());
    } catch (e) {
      return '';
    }
  }

  static String? isoDate(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat("yyyy-MM-dd", "id").format(dateTime.toLocal());
    }

    return null;
  }

  static String? isoDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      return dateTime.toLocal().toIso8601String();
    }

    return null;
  }

  static String convertToAgo(DateTime? input) {
    if (input == null) {
      return "-";
    } else {
      Duration diff = DateTime.now().difference(input);

      if (diff.inDays >= 1) {
        if (diff.inDays >= 31) {
          double inMonth = diff.inDays / 30;
          if (inMonth >= 12) {
            double inYear = inMonth / 12;
            return '${inYear.floor()} tahun lalu';
          }
          return '${inMonth.floor()} bulan lalu';
        } else {
          return '${diff.inDays} hari lalu';
        }
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} jam lalu';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} menit lalu';
      } else {
        return 'Baru saja';
      }
    }
  }

  static String due(DateTime? dateTime1, DateTime? dateTime2) {
    if (dateTime1 == null || dateTime2 == null) {
      return "-";
    } else {
      dateTime1 =
          DateTime.parse(Formats.isoDateTime(dateTime1.toLocal()).toString());
      dateTime2 =
          DateTime.parse(Formats.isoDateTime(dateTime2.toLocal()).toString());

      print("alif datetime due");
      print("${dateTime1.millisecondsSinceEpoch} ${dateTime1}");
      print("${dateTime2.millisecondsSinceEpoch} ${dateTime2}");
      print(
          dateTime1.millisecondsSinceEpoch > dateTime2.millisecondsSinceEpoch);

      // dateTime1.toLocal();
// dateTime2.toLocal();

      // int day = Jiffy.parseFromDateTime(dateTime2)
      //     .diff(Jiffy.parseFromDateTime(dateTime1), unit: Unit.day)
      //     .floor()
      //     .toInt();

      if (dateTime1.millisecondsSinceEpoch > dateTime2.millisecondsSinceEpoch) {
        int day = Jiffy.parseFromDateTime(dateTime2)
            .diff(Jiffy.parseFromDateTime(dateTime1), unit: Unit.day)
            .floor()
            .toInt();

        int hour = Jiffy.parseFromDateTime(dateTime2)
            .diff(Jiffy.parseFromDateTime(dateTime1), unit: Unit.hour)
            .floor()
            .toInt();

        int minute = Jiffy.parseFromDateTime(dateTime1)
            .diff(Jiffy.parseFromDateTime(dateTime2), unit: Unit.minute)
            .floor()
            .toInt();

        if (day != 0) {
          return "Out ${day.abs()} Days";
        } else if (hour != 0) {
          return "Out ${hour.abs()} Hours";
        } else {
          return "Out ${minute.abs()} Minutes";
        }
      } else {
        int day = Jiffy.parseFromDateTime(dateTime2)
            .diff(Jiffy.parseFromDateTime(dateTime1), unit: Unit.day)
            .floor()
            .toInt();

        int hour = Jiffy.parseFromDateTime(dateTime2)
            .diff(Jiffy.parseFromDateTime(dateTime1), unit: Unit.hour)
            .floor()
            .toInt();

        int minute = Jiffy.parseFromDateTime(dateTime1)
            .diff(Jiffy.parseFromDateTime(dateTime2), unit: Unit.minute)
            .floor()
            .toInt();

        if (day != 0) {
          return "In ${day.abs()} Days";
        } else if (hour != 0) {
          return "In ${hour.abs()} Hours";
        } else {
          return "In ${minute.abs()} Minutes";
        }
      }

      // if (day < 0) {
      //   if (day > 1) {
      //     int hour = Jiffy.parseFromDateTime(dateTime2)
      //         .diff(Jiffy.parseFromDateTime(dateTime1), unit: Unit.hour)
      //         .floor()
      //         .toInt();

      //     int minute = Jiffy.parseFromDateTime(dateTime2)
      //         .diff(Jiffy.parseFromDateTime(dateTime1), unit: Unit.minute)
      //         .floor()
      //         .toInt();

      //     print('if');
      //     // return "Out ${hour.abs()} Hours";
      //     if (hour != 0) {
      //       return "In ${hour.abs()} Hours";
      //     } else {
      //       return "Out ${minute.abs()} Minutes1";
      //     }
      //   } else {
      //     print('else');
      //     return "Out ${day.abs()} Days";
      //   }
      // } else {
      //   if (day < 1) {
      //     int hour = Jiffy.parseFromDateTime(dateTime1)
      //         .diff(Jiffy.parseFromDateTime(dateTime2), unit: Unit.hour)
      //         .floor()
      //         .toInt();

      //     int minute = Jiffy.parseFromDateTime(dateTime1)
      //         .diff(Jiffy.parseFromDateTime(dateTime2), unit: Unit.minute)
      //         .floor()
      //         .toInt();

      //     print("alif else due");
      //     print(hour);
      //     print(minute);

      //     if (hour > 0) {
      //       return "In ${hour.abs()} Hours";
      //     } else {
      //       if (minute > 0) {
      //         return "In ${minute.abs()} Minutes2";
      //       } else {
      //         return "Out ${minute.abs()} Minutes3";
      //       }
      //     }
      //   } else {
      //     return "In ${day.abs()} Days";
      //   }
      // }
    }
  }
}
