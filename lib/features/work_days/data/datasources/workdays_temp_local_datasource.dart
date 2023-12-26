import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:worked_days/core/errors/exceptions.dart';
import 'package:worked_days/features/work_days/data/models/workday_temporary.dart';

abstract class WorkDaysTemporaryLocalDataSource {
  Future<WorkDayTemporaryModel?> getTemporaryWorkDay();
  Future<bool> saveTemporaryWorkDay(WorkDayTemporaryModel workDayTempModel);
  Future<bool> removeTemporaryWorkDay();
}

class WorkDaysTemporaryLocalDataSourceImpl implements WorkDaysTemporaryLocalDataSource {
  final tempWorkDayKey = "tempWorkDay";
  final SharedPreferences sharedPreferences;

  WorkDaysTemporaryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> saveTemporaryWorkDay(WorkDayTemporaryModel workDayTempModel) async {
    try {
      final isInserted = await sharedPreferences.setString(
        tempWorkDayKey,
        jsonEncode(workDayTempModel.toMap()),
      );
      return isInserted;
    } catch (e) {
      throw LocalDataSourceException();
    }
  }

  @override
  Future<WorkDayTemporaryModel?> getTemporaryWorkDay() async {
    try {
      final jsonString = sharedPreferences.getString(tempWorkDayKey);
      if (jsonString != null) {
        return WorkDayTemporaryModel.fromMap(jsonDecode(jsonString));
      } else {
        return null;
      }
    } catch (e) {
      throw LocalDataSourceException();
    }
  }

  @override
  Future<bool> removeTemporaryWorkDay() async {
    try {
      final isDeleted = await sharedPreferences.remove(tempWorkDayKey);
      return isDeleted;
    } catch (e) {
      throw LocalDataSourceException();
    }
  }
}
