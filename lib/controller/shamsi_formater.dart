import 'package:shamsi_date/shamsi_date.dart';

class ShamsiFormatter {
  static getTodayFullDateTime(DateTime? dateTime) {
    JalaliFormatter dt;
    if (dateTime != null) {
      dt = dateTime.toJalali().formatter;
    } else {
      dt = Jalali.now().formatter;
    }
    return "${dt.wN} ${dt.dd} ${dt.mN} ${dt.yyyy}";
  }

  static getYearAndMonth(Jalali jl) {
    final dt = jl.formatter;

    return "${dt.yyyy} ${dt.mN} ";
  }

  static getDayAndMonth(DateTime dateTime) {
    final dt = dateTime.toJalali().formatter;

    return "${dt.wN} ${dt.dd} ${dt.mN}";
  }
}
