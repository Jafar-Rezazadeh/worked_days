import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Settings extends Equatable {
  final int salaryAmountContract;
  final int workDayTimeContractAsHours;
  final bool isNotificationActive;
  final TimeOfDay notificationPeriodTime;

  const Settings({
    required this.salaryAmountContract,
    required this.isNotificationActive,
    required this.notificationPeriodTime,
    required this.workDayTimeContractAsHours,
  });

  @override
  List<Object?> get props => [
        salaryAmountContract,
        isNotificationActive,
        notificationPeriodTime,
      ];
}
