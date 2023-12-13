import 'package:get_it/get_it.dart';
import 'features/work_days/data/datasources/workdays_local_datasource.dart';
import 'features/work_days/data/repositories/workday_repository_impl.dart';
import 'features/work_days/domain/repositories/workdays_repository.dart';
import 'features/work_days/domain/usecases/delete_work_day.dart';
import 'features/work_days/domain/usecases/get_work_days.dart';
import 'features/work_days/domain/usecases/insert_work_day.dart';
import 'features/work_days/presentation/bloc/cubit/workdays_cubit.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  //! features
  _workDayFeature();
}

void _workDayFeature() {
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
  sl.registerLazySingleton<WorkDaysLocalDataSource>(() => WorkDaysLocalDataSourceImpl());

  //! core

  //! externals
}
