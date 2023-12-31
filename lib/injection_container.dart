import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:worked_days/features/work_days/data/datasources/workdays_temp_local_datasource.dart';
import 'package:worked_days/features/work_days/domain/usecases/get_temp_work_day.dart';
import 'package:worked_days/features/work_days/domain/usecases/save_temp_workday.dart';

import 'core/shared_functions/open_sqflite_data_source.dart';
import 'features/salary/data/datasources/salary_local_datasource.dart';
import 'features/salary/data/repositories/salary_repository_impl.dart';
import 'features/salary/domain/repositories/salary_repository.dart';
import 'features/salary/domain/usecases/delete_salaries.dart';
import 'features/salary/domain/usecases/get_salaries.dart';
import 'features/salary/domain/usecases/insert_salary.dart';
import 'features/salary/presentation/bloc/cubit/salary_cubit.dart';
import 'features/settings/data/data_sources/settings_local_data_source.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/domain/usecases/delete_settings.dart';
import 'features/settings/domain/usecases/get_settings.dart';
import 'features/settings/domain/usecases/insert_settings.dart';
import 'features/settings/presentation/cubit/cubit/settings_cubit.dart';
import 'features/work_days/data/datasources/workdays_local_datasource.dart';
import 'features/work_days/data/repositories/workday_repository_impl.dart';
import 'features/work_days/domain/repositories/workdays_repository.dart';
import 'features/work_days/domain/usecases/delete_work_day.dart';
import 'features/work_days/domain/usecases/get_work_days.dart';
import 'features/work_days/domain/usecases/insert_work_day.dart';
import 'features/work_days/presentation/bloc/cubit/workdays_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  final Database localDatabase = await openSqfliteDataSource();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //! features
  await _workDayFeature(localDatabase, sharedPreferences);
  await _salaryFeature(localDatabase);
  await _settingsFeature(sharedPreferences);
}

Future<void> _workDayFeature(Database database, SharedPreferences sharedPreferences) async {
  //bloc
  sl.registerFactory(
    () => WorkdaysCubit(
      getWorkDaysUseCase: sl(),
      insertWorkDayUseCase: sl(),
      deleteWorkDayUseCase: sl(),
      getTempUseCase: sl(),
      saveTempUseCase: sl(),
    ),
  );

  //useCaseies
  sl.registerLazySingleton(() => GetWorkDaysUseCase(workDaysRepository: sl()));
  sl.registerLazySingleton(() => InsertWorkDayUseCase(workDaysRepository: sl()));
  sl.registerLazySingleton(() => DeleteWorkDayUseCase(workDaysRepository: sl()));
  sl.registerLazySingleton(() => GetTemporaryWorkDayUseCase(workDaysRepository: sl()));
  sl.registerLazySingleton(() => SaveTemporaryWorkDayUseCase(workDaysRepository: sl()));

  //repositories
  sl.registerLazySingleton<WorkDaysRepository>(
    () => WorkDaysRepositoryImpl(
      workDaysLocalDataSource: sl(),
      temporaryLocalDataSource: sl(),
    ),
  );

  //dataSources
  sl.registerLazySingleton<WorkDaysLocalDataSource>(
    () => WorkDaysLocalDataSourceImpl(database: database),
  );
  sl.registerLazySingleton<WorkDaysTemporaryLocalDataSource>(
    () => WorkDaysTemporaryLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );

  //! core

  //! externals
}

Future<void> _salaryFeature(Database database) async {
  //bloc
  sl.registerFactory(
    () => SalaryCubit(
      getSalariesUseCase: sl(),
      insertSalaryUseCase: sl(),
      deleteSalaryUseCase: sl(),
    ),
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

_settingsFeature(SharedPreferences sharedPreferences) {
  //bloc
  sl.registerFactory(
    () => SettingsCubit(
      deleteSettingsUseCase: sl(),
      insertSettingsUseCase: sl(),
      getSettingsUseCase: sl(),
    ),
  );

  //usecases
  sl.registerLazySingleton(
    () => DeleteSettingsUseCase(settingsRepository: sl()),
  );
  sl.registerLazySingleton(
    () => InsertSettingsUseCase(settingsRepository: sl()),
  );
  sl.registerLazySingleton(
    () => GetSettingsUseCase(settingsRepository: sl()),
  );

  //repositories
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(dataSource: sl()),
  );

  //datasources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );

  //! core

  //! externals
}
