import 'package:worked_days/bloc/entities/notification_pref_model.dart';
import 'package:worked_days/bloc/entities/salary_model.dart';
import 'package:worked_days/bloc/entities/settings_model.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';

abstract class MainCubitState {}

final class MainCubitInitial extends MainCubitState {}

class LoadingState extends MainCubitState {}

class LoadedStableState extends MainCubitState {
  final List<WorkDayModel> workedDays;
  final NotificationPrefModel notificationSettings;
  final SettingsModel settingsModel;
  final List<SalaryModel> salaries;

  LoadedStableState({
    required this.workedDays,
    required this.notificationSettings,
    required this.settingsModel,
    required this.salaries,
  });
}
