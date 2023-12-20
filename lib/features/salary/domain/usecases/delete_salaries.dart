import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase_contract.dart';
import '../repositories/salary_repository.dart';

class DeleteSalaryUseCase implements UseCaseContract<int, int> {
  final SalaryRepository salaryRepository;

  DeleteSalaryUseCase({required this.salaryRepository});
  @override
  Future<Either<Failure, int>> call(params) async {
    return await salaryRepository.deleteSalary(params);
  }
}
