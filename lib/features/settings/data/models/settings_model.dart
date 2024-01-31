import 'package:worked_days/core/constacts/constacts.dart';

import '../../../../core/utils/extentions.dart';
import '../../domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel({
    required super.salaryAmountContract,
    required super.isNotificationActive,
    required super.notificationPeriodTime,
    required super.workDayTimeContractAsHours,
  });

  factory SettingsModel.fromMap(Map<String, dynamic> mapData) {
    return SettingsModel(
      workDayTimeContractAsHours:
          mapData['workDayTimeContractAsHours'] ?? defaultSettings.workDayTimeContractAsHours,
      salaryAmountContract: mapData['salaryAmountContract'] ?? defaultSettings.salaryAmountContract,
      isNotificationActive: mapData['isNotificationActive'] ?? defaultSettings.isNotificationActive,
      notificationPeriodTime: mapData['notificationPeriodTime']?.toString().toTimeOfDayFormat ??
          defaultSettings.notificationPeriodTime,
    );
  }

  factory SettingsModel.fromEntity(Settings settings) {
    return SettingsModel(
      workDayTimeContractAsHours: settings.workDayTimeContractAsHours,
      salaryAmountContract: settings.salaryAmountContract,
      isNotificationActive: settings.isNotificationActive,
      notificationPeriodTime: settings.notificationPeriodTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workDayTimeContractAsHours': workDayTimeContractAsHours,
      'salaryAmountContract': salaryAmountContract,
      'isNotificationActive': isNotificationActive,
      'notificationPeriodTime': notificationPeriodTime.toStringFormat,
    };
  }
}
