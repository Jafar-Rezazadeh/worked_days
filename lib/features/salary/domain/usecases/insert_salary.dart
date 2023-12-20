import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase_contract.dart';
import '../entities/salary.dart';
import '../repositories/salary_repository.dart';

class InsertSalaryUseCase implements UseCaseContract<int, Salary> {
  final SalaryRepository salaryRepository;

  InsertSalaryUseCase({required this.salaryRepository});
  @override
  Future<Either<Failure, int>> call(params) async {
    return await salaryRepository.insertSalary(params);
  }
}
