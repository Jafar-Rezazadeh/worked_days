import 'package:worked_days/models/tables_column_names.dart';

class WorkDayModel {
  int id;
  final String title;
  final DateTime dateTime;
  String? inTime;
  String? outTime;
  String? shortDescription;
  final bool workDay;
  final bool dayOff;
  final bool publicHoliday;

  WorkDayModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.dateTime,
    required this.inTime,
    required this.outTime,
    required this.workDay,
    required this.dayOff,
    required this.publicHoliday,
  });

  Map<String, dynamic> toMap_() {
    return {
      WorkedDaysColumnNames.title.name: title,
      WorkedDaysColumnNames.shortDescription.name: shortDescription,
      WorkedDaysColumnNames.dateTime.name: dateTime.toIso8601String(),
      WorkedDaysColumnNames.inTime.name: inTime,
      WorkedDaysColumnNames.outTime.name: outTime,
      WorkedDaysColumnNames.workDay.name: workDay == true ? 1 : 0,
      WorkedDaysColumnNames.dayOff.name: dayOff == true ? 1 : 0,
      WorkedDaysColumnNames.publicHoliday.name: publicHoliday == true ? 1 : 0,
    };
  }
}
