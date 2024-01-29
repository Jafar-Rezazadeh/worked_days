import 'package:flutter/material.dart';

import '../../features/settings/domain/entities/settings.dart';

const String workDayTableName = "WorkedDays";
const String salariesTableName = "Salaries";

enum WorkDayColumns {
  id,
  title,
  shortDescription,
  dateTime,
  inTime,
  outTime,
  workDay,
  dayOff,
  publicHoliday,
}

enum SalariesColumns {
  id,
  salary,
  dateTime,
}

const defaultSettings = Settings(
  workDayTimeContractAsHours: 10,
  salaryAmountContract: 0,
  isNotificationActive: true,
  notificationPeriodTime: TimeOfDay(hour: 18, minute: 00),
);
