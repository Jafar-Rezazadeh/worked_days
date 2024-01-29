import 'package:sqflite/sqflite.dart';

import '../../../../core/constacts/constacts.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/salary_model.dart';

abstract class SalaryLocalDataSource {
  Future<List<SalaryModel>> getSalaries();
  Future<int> insertSalary(SalaryModel salaryModel);
  Future<int> deleteSalary(int id);
}

class SalaryLocalDataSourceImpl implements SalaryLocalDataSource {
  final Database database;

  SalaryLocalDataSourceImpl({required this.database});

  @override
  Future<List<SalaryModel>> getSalaries() async {
    try {
      final rawData = await database.query(salariesTableName);

      final List<SalaryModel> salaries = List.generate(
        rawData.length,
        (i) => SalaryModel.fromMap(rawData[i]),
      );

      return salaries;
    } catch (e) {
      throw LocalDataSourceException(message: e.toString());
    }
  }

  @override
  Future<int> insertSalary(SalaryModel salaryModel) async {
    try {
      final int id = await database.insert(salariesTableName, salaryModel.toMap());

      return id;
    } catch (e) {
      throw LocalDataSourceException(message: e.toString());
    }
  }

  @override
  Future<int> deleteSalary(int id) async {
    try {
      final count = database.delete(
        salariesTableName,
        where: '${SalariesColumns.id.name} = ?',
        whereArgs: [id],
      );

      return count;
    } catch (e) {
      throw LocalDataSourceException(message: e.toString());
    }
  }
}
