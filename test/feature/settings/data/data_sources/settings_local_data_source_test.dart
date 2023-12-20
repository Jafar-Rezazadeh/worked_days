import 'dart:convert';

import 'package:flutter/src/material/time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worked_days/core/errors/exceptions.dart';
import 'package:worked_days/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:worked_days/features/settings/data/models/settings_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SettingsLocalDataSourceImpl tSettingsLocalDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;
  late SettingsModel mockSettingsModel;

  setUp(() {
    mockSettingsModel = const SettingsModel(
      isNotificationActive: false,
      notificationPeriodTime: TimeOfDay(hour: 0, minute: 0),
      salaryAmountContract: 0,
    );
    mockSharedPreferences = MockSharedPreferences();
    tSettingsLocalDataSourceImpl =
        SettingsLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group(
    "Get Settings -",
    () {
      test(
        "should return settingsModel when there is data and not null and no exception",
        () async {
          //arrange

          when(
            () => mockSharedPreferences.getString(any<String>()),
          ).thenAnswer((invocation) {
            return jsonEncode(mockSettingsModel.toMap());
          });

          //act
          final settingsModel = await tSettingsLocalDataSourceImpl.getSettings();

          //assert
          expect(settingsModel, isA<SettingsModel>());
        },
      );

      test(
        "should return null when there isNot data and no exception",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.getString(any<String>()),
          ).thenAnswer((invocation) => null);

          //act
          final settingModel = await tSettingsLocalDataSourceImpl.getSettings();

          //assert
          expect(settingModel, null);
        },
      );

      test(
        "should throw LocalDataSourceException when there is an exception",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.getString(any<String>()),
          ).thenAnswer((invocation) {
            throw Exception();
          });

          //act
          final settingsModel = tSettingsLocalDataSourceImpl.getSettings();
          //assert
          expect(settingsModel, throwsA(isA<LocalDataSourceException>()));
        },
      );
    },
  );

  group(
    "Insert Settings -",
    () {
      test(
        "should retrun true when data is inserted",
        () async {
          //arrange

          when(
            () => mockSharedPreferences.setString(
              any<String>(),
              jsonEncode(mockSettingsModel.toMap()),
            ),
          ).thenAnswer((invocation) async => true);

          //act
          final isInserted = await tSettingsLocalDataSourceImpl.insertSettings(mockSettingsModel);

          //assert
          expect(isInserted, true);
        },
      );

      test(
        "should return false when Data is Not Inserted",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.remove(any()),
          ).thenAnswer((invocation) async => false);

          //act
          final isInserted = await tSettingsLocalDataSourceImpl.deleteSettings();

          //assert
          expect(isInserted, false);
        },
      );

      test(
        "should return LocalDataSourceException when an exception occure",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.setString(any<String>(), any()),
          ).thenAnswer(
            (invocation) async => throw Exception(),
          );

          //act
          final isInserted = tSettingsLocalDataSourceImpl.insertSettings(mockSettingsModel);
          //assert
          expect(isInserted, throwsA(isA<LocalDataSourceException>()));
        },
      );
    },
  );

  group(
    "Delete Settings -",
    () {
      test(
        "should return true when delete is succesful",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.remove(any<String>()),
          ).thenAnswer((invocation) async => true);
          final isDeleted = await tSettingsLocalDataSourceImpl.deleteSettings();
          //assert
          expect(isDeleted, true);
        },
      );

      test(
        "should return false when data is Not deleted",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.remove(any()),
          ).thenAnswer((invocation) async => false);

          //act
          final isDeleted = await tSettingsLocalDataSourceImpl.deleteSettings();

          //assert
          expect(isDeleted, false);
        },
      );

      test(
        "should return LocalDataSourceException when there is an Excetion",
        () {
          //arrange
          when(
            () => mockSharedPreferences.remove(any()),
          ).thenAnswer((invocation) => throw Exception());

          //act
          final isDeleted = tSettingsLocalDataSourceImpl.deleteSettings();

          //assert
          expect(isDeleted, throwsA(isA<LocalDataSourceException>()));
        },
      );
    },
  );
}
