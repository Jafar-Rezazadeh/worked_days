import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/salary.dart';
import '../../domain/repositories/salary_repository.dart';
import '../datasources/salary_local_datasource.dart';
import '../models/salary_model.dart';

class SalaryRepositoryImpl implements SalaryRepository {
  final SalaryLocalDataSource salaryLocalDataSource;

  SalaryRepositoryImpl({required this.salaryLocalDataSource});

  @override
  Future<Either<Failure, List<Salary>>> getSalaries() async {
    try {
      final list = await salaryLocalDataSource.getSalaries();

      return right(list);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(
          message: "there is an issue in local data source while geting salaries data",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> insertSalary(Salary salary) async {
    try {
      final id = await salaryLocalDataSource.insertSalary(SalaryModel.fromEntity(salary));

      return right(id);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(
          message: "there is problem in local data source while inserting data",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> deleteSalary(int id) async {
    try {
      final count = await salaryLocalDataSource.deleteSalary(id);
      return right(count);
    } on LocalDataSourceException {
      return left(
        const LocalDataFailure(message: "LocalDataSource: an issue while deleting salary"),
      );
    }
  }
}
