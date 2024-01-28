import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/salary.dart';

abstract class SalaryRepository {
  Future<Either<Failure, List<SalaryEntity>>> getSalaries();
  Future<Either<Failure, int>> insertSalary(SalaryEntity salary);
  Future<Either<Failure, int>> deleteSalary(int id);
}
