import 'package:shamsi_date/shamsi_date.dart';

class FormatJalaliTo {
  static getTodayFullDateTime(DateTime? dateTime) {
    JalaliFormatter dt;
    if (dateTime != null) {
      dt = dateTime.toJalali().formatter;
    } else {
      dt = Jalali.now().formatter;
    }
    return "${dt.wN} ${dt.dd} ${dt.mN} ${dt.yyyy}";
  }

  static yearAndMonth(Jalali jl) {
    final dt = jl.formatter;

    return "${dt.yyyy} ${dt.mN} ";
  }

  static dayAndMonth(DateTime dateTime) {
    final dt = dateTime.toJalali().formatter;

    return "${dt.wN} ${dt.dd} ${dt.mN}";
  }
}
