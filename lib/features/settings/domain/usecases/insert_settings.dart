import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase_contract.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

class InsertSettingsUseCase implements UseCaseContract<bool, Settings> {
  final SettingsRepository settingsRepository;

  InsertSettingsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, bool>> call(Settings params) async {
    return await settingsRepository.insertSettings(params);
  }
}
