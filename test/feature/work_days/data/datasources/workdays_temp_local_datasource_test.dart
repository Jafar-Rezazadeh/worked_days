import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worked_days/core/errors/exceptions.dart';
import 'package:worked_days/features/work_days/data/datasources/workdays_temp_local_datasource.dart';
import 'package:worked_days/features/work_days/data/models/workday_temporary.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late WorkDaysTemporaryLocalDataSourceImpl dataSourceImpl;

  late WorkDayTemporaryModel workDayTempModel;

  setUp(() {
    workDayTempModel = WorkDayTemporaryModel(
      inTime: TimeOfDay.now(),
      outTime: TimeOfDay.now(),
    );

    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = WorkDaysTemporaryLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group(
    "GetTemporaryWorkDay -",
    () {
      test(
        "should return a WorkDayModel when all success.",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.getString(any()),
          ).thenAnswer((invocation) => jsonEncode(workDayTempModel.toMap()));

          //act
          final result = await dataSourceImpl.getTemporaryWorkDay();

          //assert
          expect(result, isA<WorkDayTemporaryModel>());
        },
      );

      test(
        "should return null when nodata with No exception.",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.getString(any()),
          ).thenAnswer((invocation) => null);

          //act
          final result = await dataSourceImpl.getTemporaryWorkDay();

          //assert
          expect(result, null);
        },
      );

      test(
        "should throw localDataSourceException when there is an exception",
        () {
          //arrange
          when(
            () => mockSharedPreferences.getString(any()),
          ).thenAnswer((invocation) => throw Exception());

          //act
          final result = dataSourceImpl.getTemporaryWorkDay();

          //assert
          expect(result, throwsA(isA<LocalDataSourceException>()));
        },
      );
    },
  );

  group(
    "SaveTempWorkDay -",
    () {
      test(
        "should retunr true when all success.",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.setString(any(), any()),
          ).thenAnswer((invocation) async => true);

          //act
          final result = await dataSourceImpl.saveTemporaryWorkDay(workDayTempModel);

          //assert
          expect(result, true);
        },
      );

      test(
        "should retun false when Not inserted with No Exception",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.setString(any(), any()),
          ).thenAnswer((invocation) async => false);

          //act
          final result = await dataSourceImpl.saveTemporaryWorkDay(workDayTempModel);

          //assert
          expect(result, false);
        },
      );

      test(
        "should throw localDataSourceException when there is an exception",
        () {
          //arrange
          when(
            () => mockSharedPreferences.setString(any(), any()),
          ).thenAnswer((invocation) => throw Exception());

          //act
          final result = dataSourceImpl.saveTemporaryWorkDay(workDayTempModel);

          //assert
          expect(result, throwsA(isA<LocalDataSourceException>()));
        },
      );
    },
  );

  group(
    "RemoveTempWorkDay -",
    () {
      test(
        "should return true when Deleted.",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.remove(any()),
          ).thenAnswer((invocation) async => true);

          //act
          final result = await dataSourceImpl.removeTemporaryWorkDay();

          //assert
          expect(result, true);
        },
      );

      test(
        "should return false when Not deleted with No Exception",
        () async {
          //arrange
          when(
            () => mockSharedPreferences.remove(any()),
          ).thenAnswer((invocation) async => false);

          //act
          final result = await dataSourceImpl.removeTemporaryWorkDay();

          //assert
          expect(result, false);
        },
      );

      test(
        "should throw localDataSourceException when there is an exception",
        () {
          //arrange
          when(
            () => mockSharedPreferences.remove(any()),
          ).thenAnswer((invocation) => throw Exception());

          //act
          final result = dataSourceImpl.removeTemporaryWorkDay();

          //assert
          expect(result, throwsA(isA<LocalDataSourceException>()));
        },
      );
    },
  );
}
