part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitialState extends SettingsState {}

final class SettingsLoadingState extends SettingsState {}

final class SettingsLoadedState extends SettingsState {
  final Settings settings;

  const SettingsLoadedState({required this.settings});

  @override
  List<Object> get props => [settings];
}

final class SettingsErrorState extends SettingsState {
  final String errorMessage;

  const SettingsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
