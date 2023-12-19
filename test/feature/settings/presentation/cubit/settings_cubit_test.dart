import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib-copy/features/settings/presentation/cubit/cubit/settings_cubit.dart';
import 'mocks/mock_classes.dart';

void main() {
  late FakeSettings fakeSettings;
  late DefaultDeleteSettingsMock noActionDelete;
  late DefaultInsertSettingsMock noActionInsert;
  late DefaultGetSettingsMock noActionGet;

  setUp(() {
    noActionDelete = DefaultDeleteSettingsMock();
    noActionInsert = DefaultInsertSettingsMock();
    noActionGet = DefaultGetSettingsMock();
    fakeSettings = FakeSettings();
  });

  group(
    "Get Settings -",
    () {
      blocTest<SettingsCubit, SettingsState>(
        "should emit [SettingsLoadingState, SettingsLoadedState] when getSetting called and success.",
        build: () => SettingsCubit(
          deleteSettingsUseCase: noActionDelete,
          insertSettingsUseCase: noActionInsert,
          getSettingsUseCase: GetSettingsSuccessMock(),
        ),
        act: (cubit) => cubit.getSettings(),
        expect: () => [
          isA<SettingsLoadingState>(),
          isA<SettingsLoadedState>(),
        ],
      );
      blocTest<SettingsCubit, SettingsState>(
        'Should emits [SettingsLoadingState, SettingsErrorState] when GetSettings called and a failure occur.',
        build: () => SettingsCubit(
          deleteSettingsUseCase: noActionDelete,
          insertSettingsUseCase: noActionInsert,
          getSettingsUseCase: GetSettingsFailureMock(),
        ),
        act: (cubit) => cubit.getSettings(),
        expect: () => [
          isA<SettingsLoadingState>(),
          isA<SettingsErrorState>(),
        ],
      );
    },
  );

  group("Insert Settings -", () {
    blocTest<SettingsCubit, SettingsState>(
      'Should emits [SettingsLoadingState,SettingsLoadedState] when insert is success and data retrived succesful.',
      build: () => SettingsCubit(
        deleteSettingsUseCase: noActionDelete,
        insertSettingsUseCase: InsertSettingsSuccessMock(),
        getSettingsUseCase: GetSettingsSuccessMock(),
      ),
      act: (cubit) => cubit.insertSettings(fakeSettings),
      expect: () => [
        isA<SettingsLoadingState>(),
        isA<SettingsLoadedState>(),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'should emits [SettingsLoadingState, SettingsErrorState] when insertSettings called and Not inserted with No exception',
      build: () => SettingsCubit(
        deleteSettingsUseCase: noActionDelete,
        insertSettingsUseCase: InsertSettingsUnSuccessMock(),
        getSettingsUseCase: noActionGet,
      ),
      act: (cubit) => cubit.insertSettings(fakeSettings),
      expect: () => [
        isA<SettingsLoadingState>(),
        isA<SettingsErrorState>(),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'Should emits [SettingsLoadingState,SettingsErrorState] when insertSettings called and a failure occure',
      build: () => SettingsCubit(
        deleteSettingsUseCase: noActionDelete,
        insertSettingsUseCase: InsertSettingsFailureMock(),
        getSettingsUseCase: noActionGet,
      ),
      act: (cubit) => cubit.insertSettings(fakeSettings),
      expect: () => [
        isA<SettingsLoadingState>(),
        isA<SettingsErrorState>(),
      ],
    );
  });

  group(
    "Delete Settings -",
    () {
      blocTest<SettingsCubit, SettingsState>(
        'Should emits [SettingsLoadingState,SettingsErrorState] when deleteSettings called is success and data retrive in success.',
        build: () => SettingsCubit(
          deleteSettingsUseCase: DeleteSettingsSuccessMock(),
          insertSettingsUseCase: noActionInsert,
          getSettingsUseCase: GetSettingsSuccessMock(),
        ),
        act: (cubit) => cubit.deleteSettings(),
        expect: () => [
          isA<SettingsLoadingState>(),
          isA<SettingsLoadedState>(),
        ],
      );

      blocTest<SettingsCubit, SettingsState>(
        'should emits [SettingsLoadingState, SettingsErrorState] when deleteSettings called and Not deleted with No exception',
        build: () => SettingsCubit(
          deleteSettingsUseCase: DeleteSettingsUnSuccessMock(),
          insertSettingsUseCase: noActionInsert,
          getSettingsUseCase: noActionGet,
        ),
        act: (cubit) => cubit.deleteSettings(),
        expect: () => [
          isA<SettingsLoadingState>(),
          isA<SettingsErrorState>(),
        ],
      );

      blocTest<SettingsCubit, SettingsState>(
        'Should emits [SettingsLoadingState,SettingsErrorState] when deleteSettings called and a failure occure',
        build: () => SettingsCubit(
          deleteSettingsUseCase: DeleteSettingsFailureMock(),
          insertSettingsUseCase: noActionInsert,
          getSettingsUseCase: noActionGet,
        ),
        act: (cubit) => cubit.deleteSettings(),
        expect: () => [
          isA<SettingsLoadingState>(),
          isA<SettingsErrorState>(),
        ],
      );
    },
  );
}
