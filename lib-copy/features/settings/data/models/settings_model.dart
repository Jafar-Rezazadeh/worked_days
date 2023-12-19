import '../../../../core/utils/extentions.dart';
import '../../domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel({
    required super.salaryAmountContract,
    required super.isNotificationActive,
    required super.notificationPeriodTime,
  });

  factory SettingsModel.fromMap(Map<String, dynamic> mapData) {
    return SettingsModel(
        salaryAmountContract: mapData['salaryAmountContract'],
        isNotificationActive: mapData['isNotificationActive'],
        notificationPeriodTime: mapData['notificationPeriodTime'].toString().toTimeOfDayFormat);
  }

  factory SettingsModel.fromEntity(Settings settings) {
    return SettingsModel(
      salaryAmountContract: settings.salaryAmountContract,
      isNotificationActive: settings.isNotificationActive,
      notificationPeriodTime: settings.notificationPeriodTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'salaryAmountContract': salaryAmountContract,
      'isNotificationActive': isNotificationActive,
      'notificationPeriodTime': notificationPeriodTime.toStringFormat,
    };
  }
}
