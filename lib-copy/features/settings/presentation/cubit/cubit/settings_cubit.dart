import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  getSettings() async {
    emit(SettingsLoadingState());

    await _getSettings();
  }

  insertSettings(Settings settings) async {
    emit(SettingsLoadingState());

    final failureOrInserted = await insertSettingsUseCase(settings);

    failureOrInserted.fold(
      (failure) {
        emit(SettingsErrorState(errorMessage: failure.message));
      },
      (isInserted) async {
        if (isInserted) {
          await _getSettings();
        } else {
          emit(
            const SettingsErrorState(errorMessage: "insertation failed but no exception occured"),
          );
        }
      },
    );
  }

  deleteSettings() async {
    emit(SettingsLoadingState());

    final failureOrIsDeleted = await deleteSettingsUseCase(NoParams());

    failureOrIsDeleted.fold(
      (failure) {
        emit(SettingsErrorState(errorMessage: failure.message));
      },
      (isDeleted) async {
        if (isDeleted) {
          await _getSettings();
        } else {
          emit(
            const SettingsErrorState(errorMessage: "deletation failed with no exception"),
          );
        }
      },
    );
  }

//local functions
  Future<void> _getSettings() async {
    final failureOrSettings = await getSettingsUseCase(NoParams());

    failureOrSettings.fold(
      (failure) {
        emit(SettingsErrorState(errorMessage: failure.message));
      },
      (settings) {
        emit(SettingsLoadedState(settings: settings));
      },
    );
  }
}
