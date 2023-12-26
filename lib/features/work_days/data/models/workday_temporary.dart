import 'package:worked_days/core/utils/extentions.dart';
import 'package:worked_days/features/work_days/domain/entities/work_day_temp.dart';

class WorkDayTemporaryModel extends WorkDayTemporary {
  WorkDayTemporaryModel({required super.inTime, required super.outTime});

  Map<String, dynamic> toMap() {
    return {
      "inTime": inTime?.toStringFormat,
      "outTime": outTime?.toStringFormat,
    };
  }

  factory WorkDayTemporaryModel.fromMap(Map<String, dynamic> map) {
    return WorkDayTemporaryModel(
      inTime: map["inTime"]?.toString().toTimeOfDayFormat,
      outTime: map["outTime"]?.toString().toTimeOfDayFormat,
    );
  }
  factory WorkDayTemporaryModel.fromEntity(WorkDayTemporary workDayTemporary) {
    return WorkDayTemporaryModel(
      inTime: workDayTemporary.inTime,
      outTime: workDayTemporary.outTime,
    );
  }
}
