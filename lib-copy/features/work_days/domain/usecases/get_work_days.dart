import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase_contract.dart';
import '../entities/work_days.dart';
import '../repositories/workdays_repository.dart';

class GetWorkDaysUseCase implements UseCaseContract {
  final WorkDaysRepository workDaysRepository;

  GetWorkDaysUseCase({required this.workDaysRepository});

  @override
  Future<Either<Failure, List<WorkDay>>> call(params) async {
    return await workDaysRepository.getWorkDays();
  }
}
