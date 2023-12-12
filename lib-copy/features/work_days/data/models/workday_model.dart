import '../../../../core/constants/constants.dart';
import '../../../../core/utils/extentions.dart';
import '../../domain/entities/work_days.dart';

class WorkDayModel extends WorkDay {
  WorkDayModel(
      {required super.id,
      required super.title,
      required super.shortDescription,
      required super.date,
      required super.inTime,
      required super.outTime,
      required super.isWorkDay,
      required super.isDayOff,
      required super.isPublicHoliday});

  factory WorkDayModel.fromMap(Map<String, dynamic> rawData) {
    bool isOrNot(int rawData) {
      return rawData == 1 ? true : false;
    }

    return WorkDayModel(
      id: rawData[WorkDayColumns.id.name],
      title: rawData[WorkDayColumns.title.name],
      shortDescription: rawData[WorkDayColumns.shortDescription.name],
      date: DateTime.parse(rawData[WorkDayColumns.dateTime.name]),
      inTime: rawData[WorkDayColumns.inTime.name].toString().toTimeOfDayFormat,
      outTime: rawData[WorkDayColumns.outTime.name].toString().toTimeOfDayFormat,
      isWorkDay: isOrNot(rawData[WorkDayColumns.workDay.name]),
      isDayOff: isOrNot(rawData[WorkDayColumns.dayOff.name]),
      isPublicHoliday: isOrNot(rawData[WorkDayColumns.publicHoliday.name]),
    );
  }

  Map<String, dynamic> toMap() {
    isOrNot(bool bool) {
      return bool == true ? 1 : 0;
    }

    return {
      WorkDayColumns.title.name: title,
      WorkDayColumns.shortDescription.name: shortDescription,
      WorkDayColumns.dateTime.name: date.toIso8601String(),
      WorkDayColumns.inTime.name: inTime?.toStringFormat,
      WorkDayColumns.outTime.name: outTime?.toStringFormat,
      WorkDayColumns.workDay.name: isOrNot(isWorkDay),
      WorkDayColumns.dayOff.name: isOrNot(isDayOff),
      WorkDayColumns.publicHoliday.name: isOrNot(isPublicHoliday),
    };
  }

  factory WorkDayModel.fromEntity(WorkDay workDay) {
    return WorkDayModel(
      id: workDay.id,
      title: workDay.title,
      shortDescription: workDay.shortDescription,
      date: workDay.date,
      inTime: workDay.inTime,
      outTime: workDay.outTime,
      isWorkDay: workDay.isWorkDay,
      isDayOff: workDay.isDayOff,
      isPublicHoliday: workDay.isPublicHoliday,
    );
  }
}
