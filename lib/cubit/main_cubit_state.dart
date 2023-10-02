import 'package:flutter/material.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/worked_day_model.dart';

abstract class MainCubitState {}

final class MainCubitInitial extends MainCubitState {}

class LoadingState extends MainCubitState {}

class LoadedStableState extends MainCubitState {
  final Size screenSize;
  final List<WorkDayModel> workedDays;
  final NotificationPrefModel notificationSettings;

  LoadedStableState({
    required this.screenSize,
    required this.workedDays,
    required this.notificationSettings,
  });
}
