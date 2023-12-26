import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/features/work_days/domain/entities/work_day_temp.dart';
import 'package:worked_days/features/work_days/domain/usecases/get_temp_work_day.dart';
import 'package:worked_days/features/work_days/domain/usecases/save_temp_workday.dart';

import '../../../../../core/usecases/usecase_contract.dart';
import '../../../domain/entities/work_days.dart';
import '../../../domain/usecases/delete_work_day.dart';
import '../../../domain/usecases/get_work_days.dart';
import '../../../domain/usecases/insert_work_day.dart';

part 'workdays_state.dart';

class WorkdaysCubit extends Cubit<WorkdaysState> {
  final GetWorkDaysUseCase getWorkDaysUseCase;
  final InsertWorkDayUseCase insertWorkDayUseCase;
  final DeleteWorkDayUseCase deleteWorkDayUseCase;
  final SaveTemporaryWorkDayUseCase saveTempUseCase;
  final GetTemporaryWorkDayUseCase getTempUseCase;

  WorkdaysCubit({
    required this.saveTempUseCase,
    required this.getTempUseCase,
    required this.getWorkDaysUseCase,
    required this.insertWorkDayUseCase,
    required this.deleteWorkDayUseCase,
  }) : super(WorkDaysInitialState());

// Actions
  Future<List<WorkDay>> getWorkDays() async {
    emit(WorkDaysLoadingState());

    return _getWorkDays();
  }

  insertWorkDay(WorkDay workDay) async {
    if (workDay.isWorkDay) {
      if (workDay.inTime == null || workDay.outTime == null) {
        _saveTempOrInsertWorkDay(workDay);
      } else {
        await _insertWorkDay(workDay);
      }
    } else {
      await _insertWorkDay(workDay);
    }
  }

  Future<int> deleteWorkDay(int id) async {
    emit(WorkDaysLoadingState());

    final failureOrCount = await deleteWorkDayUseCase(id);

    return failureOrCount.fold(
      (failure) {
        emit(WorkDaysErrorState(message: failure.message));
        return 0;
      },
      (id) {
        _getWorkDays();
        return id;
      },
    );
  }

// local dunctions

  Future<int> _insertWorkDay(WorkDay workDay) async {
    emit(WorkDaysLoadingState());

    final failureOrId = await insertWorkDayUseCase(workDay);

    return failureOrId.fold(
      (failure) {
        emit(WorkDaysErrorState(message: failure.message));
        return 0;
      },
      (id) {
        _getWorkDays();
        return id;
      },
    );
  }

  _saveTempOrInsertWorkDay(WorkDay workDay) async {
    final workDayTemp = WorkDayTemporary(inTime: workDay.inTime, outTime: workDay.outTime);

    final failureOrIsSaved = await saveTempUseCase.call(workDayTemp);

    failureOrIsSaved.fold(
      (failure) {
        emit(WorkDaysErrorState(message: failure.message));
      },
      (isSaved) {
        _getWorkDays(workDayTemp: workDayTemp);
      },
    );
  }

  Future<List<WorkDay>> _getWorkDays({WorkDayTemporary? workDayTemp}) async {
    if (workDayTemp == null) {
      final failureOrTemp = await getTempUseCase(NoParams());
      failureOrTemp.fold(
        (failure) {
          emit(WorkDaysErrorState(message: failure.message));
          return;
        },
        (tempWorkDay) {
          workDayTemp = tempWorkDay;
        },
      );
    }
    final failureOrListofWorkDay = await getWorkDaysUseCase(NoParams());

    failureOrListofWorkDay.fold(
      (failure) {
        emit(WorkDaysErrorState(message: failure.message));
        return [];
      },
      (listOfWorkday) {
        emit(WorkDaysLoadedState(listOfWorkDay: listOfWorkday, workDayTemporary: workDayTemp));
        return listOfWorkday;
      },
    );
    return [];
  }
}
