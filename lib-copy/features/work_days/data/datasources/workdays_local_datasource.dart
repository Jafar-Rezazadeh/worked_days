import '../../../../core/errors/exceptions.dart';
import '../models/workday_model.dart';

abstract class WorkDaysLocalDataSource {
  Future<List<WorkDayModel>> getWorkDays();
  Future<bool> insertWorkDay(WorkDayModel workDayModel);
  Future<bool> deleteWorkDay(int id);
}

class WorkDaysLocalDataSourceImpl implements WorkDaysLocalDataSource {
  @override
  Future<bool> deleteWorkDay(int id) {
    throw LocalDataSourceException();
  }

  @override
  Future<List<WorkDayModel>> getWorkDays() {
    throw LocalDataSourceException();
  }

  @override
  Future<bool> insertWorkDay(WorkDayModel workDayModel) {
    throw LocalDataSourceException();
  }
}
