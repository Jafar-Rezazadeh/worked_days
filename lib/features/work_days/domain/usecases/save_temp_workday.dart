import 'package:dartz/dartz.dart';
import 'package:worked_days/core/errors/failures.dart';
import 'package:worked_days/core/usecases/usecase_contract.dart';
import 'package:worked_days/features/work_days/domain/entities/work_day_temp.dart';
import 'package:worked_days/features/work_days/domain/repositories/workdays_repository.dart';

class SaveTemporaryWorkDayUseCase implements UseCaseContract<bool, WorkDayTemporary> {
  final WorkDaysRepository workDaysRepository;

  SaveTemporaryWorkDayUseCase({required this.workDaysRepository});

  @override
  Future<Either<Failure, bool>> call(params) async {
    return await workDaysRepository.saveTemporaryWorkDay(params);
  }
}
