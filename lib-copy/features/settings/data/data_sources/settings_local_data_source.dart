import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsModel?> getSettings();
  Future<bool> insertSettings(SettingsModel settings);
  Future<bool> deleteSettings();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String settingsKey = "Settings";

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<SettingsModel?> getSettings() async {
    try {
      final String? json = sharedPreferences.getString(settingsKey);

      if (json != null) {
        return SettingsModel.fromMap(jsonDecode(json));
      } else {
        return null;
      }
    } catch (e) {
      throw LocalDataSourceException();
    }
  }

  @override
  Future<bool> insertSettings(SettingsModel settingsModel) async {
    try {
      final isInserted = await sharedPreferences.setString(
        settingsKey,
        jsonEncode(settingsModel.toMap()),
      );

      return isInserted;
    } catch (e) {
      throw LocalDataSourceException();
    }
  }

  @override
  Future<bool> deleteSettings() async {
    try {
      final isDeleted = await sharedPreferences.remove(settingsKey);

      return isDeleted;
    } catch (e) {
      throw LocalDataSourceException();
    }
  }
}
