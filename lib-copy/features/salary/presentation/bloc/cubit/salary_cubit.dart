import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase_contract.dart';
import '../../../domain/entities/salary.dart';
import '../../../domain/usecases/delete_salaries.dart';
import '../../../domain/usecases/get_salaries.dart';
import '../../../domain/usecases/insert_salary.dart';

part 'salary_state.dart';

class SalaryCubit extends Cubit<SalaryState> {
  final GetSalariesUseCase getSalariesUseCase;
  final InsertSalaryUseCase insertSalaryUseCase;
  final DeleteSalaryUseCase deleteSalaryUseCase;

  SalaryCubit({
    required this.getSalariesUseCase,
    required this.insertSalaryUseCase,
    required this.deleteSalaryUseCase,
  }) : super(SalaryEmptyState());

  getSalaries() async {
    emit(SalaryLoadingState());

    await _getSalaries();
  }

  insertSalary(Salary salary) async {
    emit(SalaryLoadingState());

    final failureOrId = await insertSalaryUseCase(salary);

    failureOrId.fold(
      (failure) {
        emit(SalaryErrorState(errorMessage: failure.message));
      },
      (id) async {
        print("inserted salary id: $id");
        await _getSalaries();
      },
    );
  }

  deleteSalary(int id) async {
    emit(SalaryLoadingState());

    final failureOrDeleteCount = await deleteSalaryUseCase(id);

    failureOrDeleteCount.fold(
      (failure) {
        emit(SalaryErrorState(errorMessage: failure.message));
      },
      (deleteCount) async {
        print("deleteCount: $deleteCount");
        await _getSalaries();
      },
    );
  }

// ? local functions
  Future<void> _getSalaries() async {
    final failureOrList = await getSalariesUseCase.call(NoParams());

    failureOrList.fold(
      (failure) {
        emit(SalaryErrorState(errorMessage: failure.message));
      },
      (list) {
        emit(SalaryLoadedState(listOfSalaries: list));
      },
    );
  }
}
