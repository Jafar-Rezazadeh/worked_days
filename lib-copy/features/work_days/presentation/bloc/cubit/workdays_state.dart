part of 'workdays_cubit.dart';

sealed class WorkdaysState extends Equatable {
  const WorkdaysState();

  @override
  List<Object> get props => [];
}

final class EmptyState extends WorkdaysState {}

final class LoadingState extends WorkdaysState {}

final class LoadedState extends WorkdaysState {
  final List<WorkDay> listOfWorkDay;

  const LoadedState({required this.listOfWorkDay});

  @override
  List<Object> get props => [...super.props, listOfWorkDay];
}

final class InsertWorkDayState extends WorkdaysState {
  final int id;

  const InsertWorkDayState({required this.id});

  @override
  List<Object> get props => [...super.props, id];
}

final class ErrorState extends WorkdaysState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [...super.props, message];
}
