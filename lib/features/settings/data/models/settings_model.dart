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
      workDayTimeContractAsHours: mapData['workDayTimeContractAsHours'] ?? 10,
      salaryAmountContract: mapData['salaryAmountContract'] ?? 0,
      isNotificationActive: mapData['isNotificationActive'] ?? false,
      notificationPeriodTime: mapData['notificationPeriodTime'].toString().toTimeOfDayFormat,
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
