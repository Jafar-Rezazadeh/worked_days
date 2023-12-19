import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/work_days.dart';
import '../bloc/cubit/workdays_cubit.dart';
import 'show_all_workdays.dart';
import 'today_status/today_status.dart';

class WorkDaysMainPage extends StatefulWidget {
  const WorkDaysMainPage({super.key});

  @override
  State<WorkDaysMainPage> createState() => _WorkDaysMainPageState();
}

class _WorkDaysMainPageState extends State<WorkDaysMainPage> {
  @override
  void initState() {
    BlocProvider.of<WorkdaysCubit>(context).getWorkDays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkdaysCubit, WorkdaysState>(
      builder: (context, state) {
        if (state is WorkDaysInitialState) {
          return _emptyWidget();
        }
        if (state is WorkDaysLoadingState) {
          return _loadingWidget();
        }
        if (state is WorkDaysLoadedState) {
          return _loadedWidget(state.listOfWorkDay);
        }
        if (state is WorkDaysErrorState) {
          return _errorWidget(state);
        } else {
          return const Center(child: Text("unknown error"));
        }
      },
    );
  }

  Widget _emptyWidget() {
    return const Center(
      child: Text("the state is EmptyState"),
    );
  }

  Center _loadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _loadedWidget(List<WorkDay> listOfWorkDays_) {
    return TabBarView(
      children: [
        TodayStatusLayout(listOfWorkDay: listOfWorkDays_),
        ShowAllWorkDays(listOfWorkDays: listOfWorkDays_),
      ],
    );
  }

  Center _errorWidget(WorkDaysErrorState state) {
    return Center(
        child: Text(
      state.message,
      style: const TextStyle(color: Colors.red),
    ));
  }
}
