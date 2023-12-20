import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/core/constacts/constacts.dart';

import '../../../../../core/usecases/usecase_contract.dart';
import '../../../domain/entities/settings.dart';
import '../../../domain/usecases/delete_settings.dart';
import '../../../domain/usecases/get_settings.dart';
import '../../../domain/usecases/insert_settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;
  final InsertSettingsUseCase insertSettingsUseCase;
  final DeleteSettingsUseCase deleteSettingsUseCase;

  SettingsCubit({
    required this.deleteSettingsUseCase,
    required this.insertSettingsUseCase,
    required this.getSettingsUseCase,
  }) : super(SettingsInitialState());

  Future<Settings> getSettings() async {
    emit(SettingsLoadingState());

    return await _getSettings();
  }

  Future<bool> insertSettings(Settings settings) async {
    final failureOrInserted = await insertSettingsUseCase(settings);

    return failureOrInserted.fold(
      (failure) {
        emit(SettingsErrorState(errorMessage: failure.message));
        return false;
      },
      (isInserted) async {
        return isInserted;
      },
    );
  }

  Future<bool> deleteSettings() async {
    //emit(SettingsLoadingState());

    final failureOrIsDeleted = await deleteSettingsUseCase(NoParams());

    return failureOrIsDeleted.fold(
      (failure) {
        emit(SettingsErrorState(errorMessage: failure.message));
        return false;
      },
      (isDeleted) async {
        // if (isDeleted) {
        //   await _getSettings();
        // } else {
        //   emit(
        //     const SettingsErrorState(errorMessage: "deletation failed with no exception"),
        //   );
        // }
        return isDeleted;
      },
    );
  }

//local functions
  Future<Settings> _getSettings() async {
    final failureOrSettings = await getSettingsUseCase(NoParams());

    return failureOrSettings.fold(
      (failure) {
        emit(SettingsErrorState(errorMessage: failure.message));
        return defaultSettings;
      },
      (settings) {
        emit(SettingsLoadedState(settings: settings));
        return settings;
      },
    );
  }
}
