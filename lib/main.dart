import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/services/notification_service.dart';
import 'package:worked_days/view/screens/main_screen.dart';

void main(List<String> args) {
  runApp(const WorkedDays());

  NotificationService.initalize();
}

class WorkedDays extends StatefulWidget {
  const WorkedDays({super.key});

  @override
  State<WorkedDays> createState() => _WorkedDaysState();
}

class _WorkedDaysState extends State<WorkedDays> {
  //Todo: first clean up the codes
  //Todo: use the flutter_screenUtil package bcs the we have some problems with screen size in release mode

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Vazir",
        ),
        home: const MainScreen(),
      ),
    );
  }
}
