import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/work_days.dart';

abstract class WorkDaysRepository {
  Future<Either<Failure, List<WorkDay>>> getWorkDays();
  Future<Either<Failure, bool>> insertWorkDay({required int id});
  Future<Either<Failure, bool>> deleteWorkDay({required int id});
}
