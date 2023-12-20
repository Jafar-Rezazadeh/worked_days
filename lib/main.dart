import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/services/notification_service.dart';
import 'core/theme/theme.dart';
import 'features/app_body/presentation/body.dart';
import 'features/salary/presentation/bloc/cubit/salary_cubit.dart';
import 'features/settings/presentation/cubit/cubit/settings_cubit.dart';
import 'features/work_days/presentation/bloc/cubit/workdays_cubit.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await NotificationService.initalize();
  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        theme: MainThemeClass.lightTheme,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<WorkdaysCubit>()),
            BlocProvider(create: (context) => sl<SalaryCubit>()),
            BlocProvider(create: (context) => sl<SettingsCubit>()),
          ],
          child: const AppBody(),
        ),
      ),
    );
  }
}
