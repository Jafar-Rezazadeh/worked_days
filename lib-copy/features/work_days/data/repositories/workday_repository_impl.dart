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
  Future<Either<Failure, int>> insertWorkDay({required WorkDay workDay}) async {
    try {
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
      final int count = await workDaysLocalDataSource.deleteWorkDay(id);

      return right(count);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(
            message: "there is an error while deleting data from local data base"),
      );
    }
  }
}
