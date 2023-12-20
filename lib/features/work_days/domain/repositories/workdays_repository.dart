import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/work_days.dart';

abstract class WorkDaysRepository {
  Future<Either<Failure, List<WorkDay>>> getWorkDays();
  Future<Either<Failure, int>> insertWorkDay({required WorkDay workDay});
  Future<Either<Failure, int>> deleteWorkDay({required int id});
}
