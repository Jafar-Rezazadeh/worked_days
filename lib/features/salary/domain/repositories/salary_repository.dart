import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/salary.dart';

abstract class SalaryRepository {
  Future<Either<Failure, List<Salary>>> getSalaries();
  Future<Either<Failure, int>> insertSalary(Salary salary);
  Future<Either<Failure, int>> deleteSalary(int id);
}
