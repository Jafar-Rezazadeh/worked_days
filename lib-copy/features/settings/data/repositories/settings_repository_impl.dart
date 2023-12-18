import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/settings.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/settings_repository.dart';
import '../data_sources/settings_local_data_source.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource dataSource;

  SettingsRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Settings?>> getSettings() async {
    try {
      final Settings? settings = await dataSource.getSettings();

      return Right(settings);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(message: "LocalDataSource: an error while getting settings data"),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> insertSettings(Settings settings) async {
    try {
      //Todo: create notification if notification value was not null

      final isInserted = await dataSource.insertSettings(SettingsModel.fromEntity(settings));

      return right(isInserted);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(
            message: "LocalDataSource: an error occure while INSERTING settings data"),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> deleteSettings() async {
    try {
      //Todo: delete notification if needed
      final isDeleted = await dataSource.deleteSettings();

      return right(isDeleted);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(
            message: "LocalDataSource: an error occure while deleting settings data"),
      );
    }
  }
}
