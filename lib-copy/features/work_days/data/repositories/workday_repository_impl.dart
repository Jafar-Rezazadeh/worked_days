import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/work_days.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/workdays_repository.dart';
import '../datasources/workdays_local_datasource.dart';
import '../models/workday_model.dart';

class WorkDayRepositoryImpl implements WorkDaysRepository {
  final WorkDaysLocalDataSource workDaysLocalDataSource;

  WorkDayRepositoryImpl({required this.workDaysLocalDataSource});

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
  Future<Either<Failure, bool>> insertWorkDay({required WorkDay workDay}) async {
    try {
      final isInserted =
          await workDaysLocalDataSource.insertWorkDay(WorkDayModel.fromEntity(workDay));
      if (isInserted) {
        return right(isInserted);
      } else {
        return left(
          const UnExpectedFailure(
              message: "there is and unexpected error while inserting data to data base"),
        );
      }
    } on LocalDataSourceException {
      return left(const LocalDataFailure(
          message: "there was an error while inserting the data to local data base"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteWorkDay({required int id}) async {
    try {
      final isDeleted = await workDaysLocalDataSource.deleteWorkDay(id);
      if (isDeleted) {
        return right(isDeleted);
      } else {
        return left(const UnExpectedFailure(
            message: "there is and unexpected error while deleting data from data base"));
      }
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(
            message: "there is an error while deleting data from local data base"),
      );
    }
  }
}
