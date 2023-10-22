import 'package:worked_days/models/notification_pref_model.dart';
import 'package:worked_days/models/settings_model.dart';
import 'package:worked_days/models/worked_day_model.dart';

abstract class MainCubitState {}

final class MainCubitInitial extends MainCubitState {}

class LoadingState extends MainCubitState {}

class LoadedStableState extends MainCubitState {
  final List<WorkDayModel> workedDays;
  final NotificationPrefModel notificationSettings;
  final SettingsModel settingsModel;

  LoadedStableState({
    required this.workedDays,
    required this.notificationSettings,
    required this.settingsModel,
  });
}
