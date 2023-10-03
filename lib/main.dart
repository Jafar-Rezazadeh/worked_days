import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/services/db_provider_service.dart';
import 'package:worked_days/services/notification_service.dart';
import 'package:worked_days/controller/main_screen_controller.dart';

void main(List<String> args) {
  runApp(const WorkedDays());

  NotificationService.initalize();

  if (Platform.isWindows) {
    doWhenWindowReady(() {
      appWindow.minSize = const Size(1280, 720);
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}

class WorkedDays extends StatefulWidget {
  const WorkedDays({super.key});

  @override
  State<WorkedDays> createState() => _WorkedDaysState();
}

class _WorkedDaysState extends State<WorkedDays> {
  late Future<List<WorkDayModel>> workedDaysData;
  @override
  void initState() {
    super.initState();
    workedDaysData = DataBaseHandlerService().getWorkDays();
  }

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
