import 'package:dartz/dartz.dart';
import 'package:worked_days/core/errors/failures.dart';
import 'package:worked_days/core/usecases/usecase_contract.dart';
import 'package:worked_days/features/work_days/domain/entities/work_day_temp.dart';
import 'package:worked_days/features/work_days/domain/repositories/workdays_repository.dart';

class GetTemporaryWorkDayUseCase implements UseCaseContract<WorkDayTemporary?, NoParams> {
  final WorkDaysRepository workDaysRepository;

  GetTemporaryWorkDayUseCase({required this.workDaysRepository});
  @override
  Future<Either<Failure, WorkDayTemporary?>> call(params) async {
    return await workDaysRepository.getTemporaryWorkDay();
  }
}
