import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../domain/entities/work_days.dart';
import '../bloc/cubit/workdays_cubit.dart';
import '../widgets/list_workdays.dart';
import '../widgets/month_selector_workdays.dart';
import '../widgets/unknow_days/unknown_days_workdays.dart';

class WorkDaysPage extends StatefulWidget {
  const WorkDaysPage({super.key});

  @override
  State<WorkDaysPage> createState() => _WorkDaysPageState();
}

class _WorkDaysPageState extends State<WorkDaysPage> {
  Jalali currentDate = Jalali.now();
  @override
  void initState() {
    BlocProvider.of<WorkdaysCubit>(context).getWorkDays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkdaysCubit, WorkdaysState>(
      builder: (context, state) {
        if (state is EmptyState) {
          return _emptyWidget();
        }
        if (state is LoadingState) {
          return _loadingWidget();
        }
        if (state is LoadedState) {
          return _loadedWidget(state.listOfWorkDay);
        }
        if (state is ErrorState) {
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

  Column _loadedWidget(List<WorkDay> listOfWorkDays_) {
    return Column(
      children: [
        MonthSelectorWorkDays(
          currentDate: currentDate,
          onCurrentDateChanged: (value) => setState(() => currentDate = value),
        ),
        UnknownDaysWorkDays(
          currentDate: currentDate,
          listOfWorkDays: listOfWorkDays_,
        ),
        ListWorkDays(
          currentDate: currentDate,
          listOfWorkDays: listOfWorkDays_,
        ),
      ],
    );
  }

  Center _errorWidget(ErrorState state) {
    return Center(
        child: Text(
      state.message,
      style: const TextStyle(color: Colors.red),
    ));
  }
}
