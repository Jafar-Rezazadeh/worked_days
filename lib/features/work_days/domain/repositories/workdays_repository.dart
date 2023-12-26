import 'package:dartz/dartz.dart';
import 'package:worked_days/features/work_days/domain/entities/work_day_temp.dart';

import '../../../../core/errors/failures.dart';
import '../entities/work_days.dart';

abstract class WorkDaysRepository {
  Future<Either<Failure, List<WorkDay>>> getWorkDays();
  Future<Either<Failure, int>> insertWorkDay({required WorkDay workDay});
  Future<Either<Failure, int>> deleteWorkDay({required int id});
  Future<Either<Failure, WorkDayTemporary?>> getTemporaryWorkDay();
  Future<Either<Failure, bool>> saveTemporaryWorkDay(WorkDayTemporary workDayTemporary);
}
