import '../../../../core/constacts/constacts.dart';
import '../../domain/entities/salary.dart';

class SalaryModel extends SalaryEntity {
  SalaryModel({required super.id, required super.dateTime, required super.salaryAmount});

  factory SalaryModel.fromMap(Map<String, dynamic> mapData) {
    return SalaryModel(
      id: mapData[SalariesColumns.id.name],
      dateTime: DateTime.parse(mapData[SalariesColumns.dateTime.name]),
      salaryAmount: mapData[SalariesColumns.salary.name],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      SalariesColumns.salary.name: salaryAmount,
      SalariesColumns.dateTime.name: dateTime.toIso8601String(),
    };
  }

  factory SalaryModel.fromEntity(SalaryEntity salary) {
    return SalaryModel(
      id: salary.id,
      dateTime: salary.dateTime,
      salaryAmount: salary.salaryAmount,
    );
  }
}
