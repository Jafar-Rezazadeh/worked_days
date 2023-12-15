part of 'salary_cubit.dart';

sealed class SalaryState extends Equatable {
  const SalaryState();

  @override
  List<Object> get props => [];
}

final class SalaryEmptyState extends SalaryState {}

final class SalaryLoadingState extends SalaryState {}

final class SalaryLoadedState extends SalaryState {
  final List<Salary> listOfSalaries;

  const SalaryLoadedState({required this.listOfSalaries});

  @override
  List<Object> get props => [listOfSalaries, ...super.props];
}

final class SalaryErrorState extends SalaryState {
  final String errorMessage;

  const SalaryErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage, ...super.props];
}
