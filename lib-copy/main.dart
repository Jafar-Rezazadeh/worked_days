import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/work_days/domain/entities/work_days.dart';
import 'features/work_days/presentation/bloc/cubit/workdays_cubit.dart';
import 'injection_container.dart';

void main() async {
  initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<WorkdaysCubit>()),
        ],
        child: const Page1(),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WorkdaysCubit>(context).getWorkDays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<WorkdaysCubit>(context).getWorkDays();
            },
            child: const Text(
              "fetch data",
              textAlign: TextAlign.center,
            ),
          ),
          FloatingActionButton(
            onPressed: () async {
              WorkDay workDay = WorkDay(
                id: 0,
                title: "test",
                shortDescription: "shortDescription",
                date: DateTime.now(),
                inTime: null,
                outTime: const TimeOfDay(hour: 18, minute: 0),
                isWorkDay: true,
                isDayOff: false,
                isPublicHoliday: false,
              );

              final id = await BlocProvider.of<WorkdaysCubit>(context).insertWorkDay(workDay);
              print(id);
            },
            child: const Text(
              "insert",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: BlocBuilder<WorkdaysCubit, WorkdaysState>(
        builder: (context, state) {
          if (state is EmptyState) {
            return const Text("fire some action state is empty");
          }
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }
          if (state is LoadedState) {
            return Row(
              children: [
                IconButton(
                    onPressed: () async {
                      final effectedFields = await BlocProvider.of<WorkdaysCubit>(context)
                          .deleteWorkDay(state.listOfWorkDay.last.id);
                      print("effectedFields: $effectedFields");
                    },
                    icon: const Icon(Icons.delete)),
                Text(state.listOfWorkDay.last.title),
              ],
            );
          }
          if (state is ErrorState) {
            return Text(state.message);
          } else {
            return const Text("unknown exception");
          }
        },
      ),
    );
  }
}
