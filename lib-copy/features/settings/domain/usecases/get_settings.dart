import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase_contract.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase implements UseCaseContract<Settings, NoParams> {
  final SettingsRepository settingsRepository;

  GetSettingsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, Settings>> call(NoParams params) async {
    return await settingsRepository.getSettings();
  }
}
