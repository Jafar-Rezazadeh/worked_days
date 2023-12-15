import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase_contract.dart';
import '../entities/salary.dart';
import '../repositories/salary_repository.dart';

class GetSalariesUseCase implements UseCaseContract<List<Salary>, NoParams> {
  final SalaryRepository salaryRepository;

  GetSalariesUseCase({required this.salaryRepository});
  @override
  Future<Either<Failure, List<Salary>>> call(params) async {
    return await salaryRepository.getSalaries();
  }
}
