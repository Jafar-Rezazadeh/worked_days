import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase_contract.dart';
import '../repositories/workdays_repository.dart';

class DeleteWorkDayUseCase implements UseCaseContract {
  final WorkDaysRepository workDaysRepository;

  DeleteWorkDayUseCase({required this.workDaysRepository});
  @override
  Future<Either<Failure, int>> call(params) async {
    return await workDaysRepository.deleteWorkDay(id: params);
  }
}
