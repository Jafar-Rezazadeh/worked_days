import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/ui/theme/theme_class.dart';
import 'features/app_body/presentation/body.dart';
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
      theme: MainThemeClass.lightTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<WorkdaysCubit>()),
        ],
        child: ScreenUtilInit(
          designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
          child: const AppBody(),
        ),
      ),
    );
  }
}
