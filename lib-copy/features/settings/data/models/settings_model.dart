import '../../domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel({required super.salaryAmountContract});

  factory SettingsModel.fromMap(Map<String, dynamic> mapData) {
    return SettingsModel(
      salaryAmountContract: mapData['salaryAmountContract'],
    );
  }

  factory SettingsModel.fromEntity(Settings settings) {
    return SettingsModel(
      salaryAmountContract: settings.salaryAmountContract,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'salaryAmountContract': salaryAmountContract,
    };
  }
}
