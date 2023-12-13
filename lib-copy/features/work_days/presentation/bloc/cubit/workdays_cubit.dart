import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  WorkdaysCubit(
      {required this.getWorkDaysUseCase,
      required this.insertWorkDayUseCase,
      required this.deleteWorkDayUseCase})
      : super(EmptyState());

// Actions
  getWorkDays() async {
    emit(LoadingState());

    await _getWorkDays();
  }

  Future<int> insertWorkDay(WorkDay workDay) async {
    emit(LoadingState());

    final failureOrId = await insertWorkDayUseCase(workDay);

    return failureOrId.fold(
      (failure) {
        emit(ErrorState(message: failure.message));
        return 0;
      },
      (id) {
        _getWorkDays();
        return id;
      },
    );
  }

  Future<int> deleteWorkDay(int id) async {
    emit(LoadingState());

    final failureOrCount = await deleteWorkDayUseCase(id);

    return failureOrCount.fold(
      (failure) {
        emit(ErrorState(message: failure.message));
        return 0;
      },
      (id) {
        _getWorkDays();
        return id;
      },
    );
  }

//
  Future<void> _getWorkDays() async {
    final failureOrListofWorkDay = await getWorkDaysUseCase(NoParams());

    failureOrListofWorkDay.fold(
      (failure) {
        emit(ErrorState(message: failure.message));
      },
      (listOfWorkday) {
        emit(LoadedState(listOfWorkDay: listOfWorkday));
      },
    );
  }
}
