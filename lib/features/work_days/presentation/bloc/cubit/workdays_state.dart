part of 'workdays_cubit.dart';

sealed class WorkdaysState extends Equatable {
  const WorkdaysState();

  @override
  List<Object> get props => [];
}

final class WorkDaysInitialState extends WorkdaysState {}

final class WorkDaysLoadingState extends WorkdaysState {}

final class WorkDaysLoadedState extends WorkdaysState {
  final List<WorkDay> listOfWorkDay;

  const WorkDaysLoadedState({required this.listOfWorkDay});

  @override
  List<Object> get props => [listOfWorkDay];
}

final class WorkDaysErrorState extends WorkdaysState {
  final String message;

  const WorkDaysErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
