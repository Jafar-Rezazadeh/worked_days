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
