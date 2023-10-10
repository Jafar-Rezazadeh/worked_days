import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/services/notification_service.dart';
import 'package:worked_days/view/screens/main_screen.dart';

Future<void> main(List<String> args) async {
  await ScreenUtil.ensureScreenSize();
  runApp(const WorkedDays());

  NotificationService.initalize();
}

class WorkedDays extends StatefulWidget {
  const WorkedDays({super.key});

  @override
  State<WorkedDays> createState() => _WorkedDaysState();
}

class _WorkedDaysState extends State<WorkedDays> {
  //Todo: use the flutter_screenUtil package bcs the we have some problems with screen size in release mode

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: ScreenUtilInit(
        designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        builder: (context, child) => MaterialApp(
          theme: ThemeData(fontFamily: "Vazir"),
          home: const MainScreen(),
        ),
      ),
    );
  }
}
