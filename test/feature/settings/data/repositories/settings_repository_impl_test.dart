import 'package:flutter/src/material/time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:worked_days/core/errors/exceptions.dart';
import 'package:worked_days/core/errors/failures.dart';
import 'package:worked_days/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:worked_days/features/settings/data/models/settings_model.dart';
import 'package:worked_days/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:worked_days/features/settings/domain/entities/settings.dart';

class MockSettingsLocalDataSource extends Mock implements SettingsLocalDataSource {}

class MockSettingsModel extends Mock implements SettingsModel {}

class MockSettings extends Mock implements Settings {}

class FakeSettings extends Fake implements Settings {
  @override
  int get salaryAmountContract => 0;
  @override
  bool get isNotificationActive => false;

  @override
  TimeOfDay get notificationPeriodTime => const TimeOfDay(hour: 18, minute: 0);
}

class FakeSettingsModel extends Fake implements SettingsModel {}

void main() {
  late SettingsRepositoryImpl tSettingsRepositoryImpl;
  late MockSettingsLocalDataSource mockDataSource;
  late FakeSettings fakeSettings;

  setUpAll(() {
    registerFallbackValue(FakeSettings());
    registerFallbackValue(FakeSettingsModel());
  });

  setUp(() {
    //
    fakeSettings = FakeSettings();
    //
    mockDataSource = MockSettingsLocalDataSource();
    tSettingsRepositoryImpl = SettingsRepositoryImpl(dataSource: mockDataSource);
  });

  group(
    "Get Settings -",
    () {
      test(
        "should get Settings when there is data and no exception",
        () async {
          //arrange
          when(
            () => mockDataSource.getSettings(),
          ).thenAnswer(
            (invocation) => Future<SettingsModel?>.value(SettingsModel.fromEntity(fakeSettings)),
          );

          //act
          final failureOrSettings = await tSettingsRepositoryImpl.getSettings();
          Settings? settings = failureOrSettings.fold((l) => null, (r) => r);

          //assert
          expect(settings, isA<Settings>());
        },
      );

      test(
        "should get LocalDataFailure when there is an LocalDataSourceException",
        () async {
          //arrange
          when(
            () => mockDataSource.getSettings(),
          ).thenAnswer(
            (invocation) => throw LocalDataSourceException(),
          );

          //act
          final failureOrSettings = await tSettingsRepositoryImpl.getSettings();

          Failure? failure = failureOrSettings.fold((l) => l, (r) => null);

          //assert
          expect(failure, isA<LocalDataFailure>());
        },
      );
    },
  );

  group(
    "Insert Settings",
    () {
      test(
        "should return True when inserted and No exception",
        () async {
          //arrange
          when(
            () => mockDataSource.insertSettings(any<SettingsModel>()),
          ).thenAnswer(
            (invocation) async => Future<bool>.value(true),
          );

          //act
          final failureOrisInserted = await tSettingsRepositoryImpl.insertSettings(fakeSettings);

          final isInserted = failureOrisInserted.fold((l) => null, (r) => r);

          //assert
          expect(isInserted, true);
        },
      );

      test(
        "should return false when Not inserted and No exception",
        () async {
          //arrange
          when(
            () => mockDataSource.insertSettings(any<SettingsModel>()),
          ).thenAnswer((invocation) async => false);

          //act
          final failureOrIsinserted = await tSettingsRepositoryImpl.insertSettings(fakeSettings);
          final isInserted = failureOrIsinserted.fold((l) => null, (r) => r);

          //assert
          expect(isInserted, false);
        },
      );

      test(
        "should return LocalDataFailure when localDataSourceException throwed",
        () async {
          //arrange
          when(
            () => mockDataSource.insertSettings(any()),
          ).thenAnswer((invocation) => throw LocalDataSourceException());

          //act
          final failureOrIsInserted = await tSettingsRepositoryImpl.insertSettings(fakeSettings);
          final failure = failureOrIsInserted.fold((l) => l, (r) => null);

          //assert
          expect(failure, isA<LocalDataFailure>());
        },
      );
    },
  );

  group(
    "Delete Settings -",
    () {
      test(
        "should return True when Inserted and No Exception",
        () async {
          //arrange
          when(
            () => mockDataSource.deleteSettings(),
          ).thenAnswer((invocation) async => true);

          //act
          final failureOrIsDeleted = await tSettingsRepositoryImpl.deleteSettings();
          final isDeleted = failureOrIsDeleted.fold((l) => null, (r) => r);

          //assert
          expect(isDeleted, true);
        },
      );

      test(
        "should return false when is Not Inserted and No exception",
        () async {
          //arrange
          when(
            () => mockDataSource.deleteSettings(),
          ).thenAnswer((invocation) async => false);

          //act
          final failureOrIsDeleted = await tSettingsRepositoryImpl.deleteSettings();
          final isDeleted = failureOrIsDeleted.fold((l) => null, (r) => r);

          //assert
          expect(isDeleted, false);
        },
      );

      test(
        "should return LocalDataFailure when throw LocalDataSourceException",
        () async {
          //arrange
          when(
            () => mockDataSource.deleteSettings(),
          ).thenAnswer((invocation) => throw LocalDataSourceException());

          //act
          final failureOrIsDeleted = await tSettingsRepositoryImpl.deleteSettings();
          final failure = failureOrIsDeleted.fold((l) => l, (r) => null);

          //assert
          expect(failure, isA<LocalDataFailure>());
        },
      );
    },
  );
}
