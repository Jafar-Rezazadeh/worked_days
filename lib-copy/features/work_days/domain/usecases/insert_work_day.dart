import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase_contract.dart';
import '../repositories/workdays_repository.dart';

class InsertWorkDay implements UseCaseContract {
  final WorkDaysRepository workDaysRepository;

  InsertWorkDay({required this.workDaysRepository});

  @override
  Future<Either<Failure, dynamic>> call(params) async {
    return await workDaysRepository.insertWorkDay(workDay: params);
  }
}
