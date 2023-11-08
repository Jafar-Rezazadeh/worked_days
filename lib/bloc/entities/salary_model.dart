import 'package:worked_days/bloc/entities/tables_column_names.dart';

class SalaryModel {
  int id;
  final int salaryAmount;
  final DateTime dateTime;

  SalaryModel({
    required this.id,
    required this.salaryAmount,
    required this.dateTime,
  });

  Map<String, dynamic> tomap_() {
    return {
      SalariesColumnNames.salary.name: salaryAmount,
      SalariesColumnNames.dateTime.name: dateTime.toIso8601String(),
    };
  }
}
