import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase_contract.dart';
import '../repositories/settings_repository.dart';

class DeleteSettingsUseCase implements UseCaseContract<bool, NoParams> {
  final SettingsRepository settingsRepository;

  DeleteSettingsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await settingsRepository.deleteSettings();
  }
}
