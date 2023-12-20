import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:worked_days/core/errors/failures.dart';
import 'package:worked_days/core/usecases/usecase_contract.dart';
import 'package:worked_days/features/settings/domain/entities/settings.dart';
import 'package:worked_days/features/settings/domain/usecases/delete_settings.dart';
import 'package:worked_days/features/settings/domain/usecases/get_settings.dart';
import 'package:worked_days/features/settings/domain/usecases/insert_settings.dart';

// ! Fakes
class FakeSettings extends Fake implements Settings {}

class FakeFailure extends Fake implements LocalDataFailure {
  @override
  String get message => "failure message";
}

//! ------------------------------------------------------------------------
class DefaultGetSettingsMock extends Mock implements GetSettingsUseCase {}

// Possible Returns
class GetSettingsSuccessMock extends DefaultGetSettingsMock {
  @override
  Future<Either<Failure, Settings>> call(NoParams params) async {
    return right(FakeSettings());
  }
}

class GetSettingsFailureMock extends DefaultGetSettingsMock {
  @override
  Future<Either<Failure, Settings>> call(NoParams params) async {
    return left(FakeFailure());
  }
}

//! ------------------------------------------------------------------------
class DefaultInsertSettingsMock extends Mock implements InsertSettingsUseCase {}

// Possible Returns
class InsertSettingsSuccessMock extends DefaultInsertSettingsMock {
  @override
  Future<Either<Failure, bool>> call(Settings params) async {
    return right(true);
  }
}

class InsertSettingsUnSuccessMock extends DefaultInsertSettingsMock {
  @override
  Future<Either<Failure, bool>> call(Settings params) async {
    return right(false);
  }
}

class InsertSettingsFailureMock extends DefaultInsertSettingsMock {
  @override
  Future<Either<Failure, bool>> call(Settings params) async {
    return left(FakeFailure());
  }
}

//! ------------------------------------------------------------------------
class DefaultDeleteSettingsMock extends Mock implements DeleteSettingsUseCase {}

// Possible Returns
class DeleteSettingsSuccessMock extends DefaultDeleteSettingsMock {
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return right(true);
  }
}

class DeleteSettingsUnSuccessMock extends DefaultDeleteSettingsMock {
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return right(false);
  }
}

class DeleteSettingsFailureMock extends DefaultDeleteSettingsMock {
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return left(FakeFailure());
  }
}
