import 'package:dartz/dartz.dart';
import 'package:worked_days/features/work_days/data/datasources/workdays_temp_local_datasource.dart';
import 'package:worked_days/features/work_days/data/models/workday_temporary.dart';
import 'package:worked_days/features/work_days/domain/entities/work_day_temp.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/work_days.dart';
import '../../domain/repositories/workdays_repository.dart';
import '../datasources/workdays_local_datasource.dart';
import '../models/workday_model.dart';

class WorkDaysRepositoryImpl implements WorkDaysRepository {
  final WorkDaysTemporaryLocalDataSource temporaryLocalDataSource;
  final WorkDaysLocalDataSource workDaysLocalDataSource;

  WorkDaysRepositoryImpl({
    required this.temporaryLocalDataSource,
    required this.workDaysLocalDataSource,
  });

  @override
  Future<Either<Failure, List<WorkDay>>> getWorkDays() async {
    try {
      final List<WorkDay> listOfWorkDay = await workDaysLocalDataSource.getWorkDays();

      return right(listOfWorkDay);
    } on LocalDataSourceException {
      return left(const LocalDataFailure(
          message: "there is a problem in local data base while geting data"));
    }
  }

  @override
  Future<Either<Failure, int>> insertWorkDay({required WorkDay workDay}) async {
    try {
      await temporaryLocalDataSource.removeTemporaryWorkDay(); // removing the temp data
      final int id = await workDaysLocalDataSource.insertWorkDay(WorkDayModel.fromEntity(workDay));

      return right(id);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(
            message: "there was an error while inserting the data to local data base"),
      );
    }
  }

  @override
  Future<Either<Failure, int>> deleteWorkDay({required int id}) async {
    try {
      await temporaryLocalDataSource.removeTemporaryWorkDay(); // removing tempdata too
      final int count = await workDaysLocalDataSource.deleteWorkDay(id);

      return right(count);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(
            message: "there is an error while deleting data from local data base"),
      );
    }
  }

  @override
  Future<Either<Failure, WorkDayTemporary?>> getTemporaryWorkDay() async {
    try {
      final tempWorkDay = await temporaryLocalDataSource.getTemporaryWorkDay();

      return right(tempWorkDay);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(message: "GetTempWorkDay: an error occure while getting data"),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> saveTemporaryWorkDay(WorkDayTemporary workDayTemporary) async {
    try {
      final isSaved = await temporaryLocalDataSource.saveTemporaryWorkDay(
        WorkDayTemporaryModel.fromEntity(workDayTemporary),
      );
      return right(isSaved);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(message: "SaveTempWorkDay: an error occure while saving data"),
      );
    }
  }
}
