import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'core/shared_functions/local_data_source.dart';
import 'features/salary/data/datasources/salary_local_datasource.dart';
import 'features/salary/data/repositories/salary_repository_impl.dart';
import 'features/salary/domain/repositories/salary_repository.dart';
import 'features/salary/domain/usecases/delete_salaries.dart';
import 'features/salary/domain/usecases/get_salaries.dart';
import 'features/salary/domain/usecases/insert_salary.dart';
import 'features/salary/presentation/bloc/cubit/salary_cubit.dart';
import 'features/work_days/data/datasources/workdays_local_datasource.dart';
import 'features/work_days/data/repositories/workday_repository_impl.dart';
import 'features/work_days/domain/repositories/workdays_repository.dart';
import 'features/work_days/domain/usecases/delete_work_day.dart';
import 'features/work_days/domain/usecases/get_work_days.dart';
import 'features/work_days/domain/usecases/insert_work_day.dart';
import 'features/work_days/presentation/bloc/cubit/workdays_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  final Database localDatabase = await openLocalDataSource();
  //! features
  await _workDayFeature(localDatabase);
  await _salaryFeature(localDatabase);
}

Future<void> _workDayFeature(Database database) async {
  //bloc
  sl.registerFactory(
    () => WorkdaysCubit(
      getWorkDaysUseCase: sl(),
      insertWorkDayUseCase: sl(),
      deleteWorkDayUseCase: sl(),
    ),
  );

  //useCaseies
  sl.registerLazySingleton(() => GetWorkDaysUseCase(workDaysRepository: sl()));
  sl.registerLazySingleton(() => InsertWorkDayUseCase(workDaysRepository: sl()));
  sl.registerLazySingleton(() => DeleteWorkDayUseCase(workDaysRepository: sl()));

  //repositories
  sl.registerLazySingleton<WorkDaysRepository>(
    () => WorkDaysRepositoryImpl(
      workDaysLocalDataSource: sl(),
    ),
  );

  //dataSources
  sl.registerLazySingleton<WorkDaysLocalDataSource>(
    () => WorkDaysLocalDataSourceImpl(database: database),
  );

  //! core

  //! externals
}

Future<void> _salaryFeature(Database database) async {
  //bloc
  sl.registerFactory(
    () =>
        SalaryCubit(getSalariesUseCase: sl(), insertSalaryUseCase: sl(), deleteSalaryUseCase: sl()),
  );

  //usecases
  sl.registerLazySingleton(() => GetSalariesUseCase(salaryRepository: sl()));
  sl.registerLazySingleton(() => InsertSalaryUseCase(salaryRepository: sl()));
  sl.registerLazySingleton(() => DeleteSalaryUseCase(salaryRepository: sl()));

  //repositories
  sl.registerLazySingleton<SalaryRepository>(
    () => SalaryRepositoryImpl(salaryLocalDataSource: sl()),
  );

  //data sources
  sl.registerLazySingleton<SalaryLocalDataSource>(
    () => SalaryLocalDataSourceImpl(database: database),
  );

  //! core

  //! externals
}
