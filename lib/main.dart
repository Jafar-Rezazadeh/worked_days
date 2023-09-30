import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/provide_data_model.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/services/db_provider.dart';
import 'package:worked_days/services/notification_service.dart';
import 'package:worked_days/services/shared_preferences.dart';
import 'package:worked_days/view/screens/main_screen.dart';

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
    workedDaysData = DataBaseHandler().getWorkDays();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([workedDaysData, SharedPreferencesService.getShowNotificationsPref()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _setProviderData(
            snapshot.data![0] as List<WorkDayModel>,
            snapshot.data![1] as NotificationPrefModel,
          );
        } else {
          return _loading();
        }
      },
    );
  }

  Widget _setProviderData(List<WorkDayModel> data, NotificationPrefModel settingsModel) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxHeight > 0) {
        return ChangeNotifierProvider(
          create: (context) => ProviderDataModel(
            screenSize: Size(constraints.maxWidth, constraints.maxHeight),
            workedDays: data,
            notificationSettings: settingsModel,
          ),
          builder: (context, child) => MaterialApp(
            theme: ThemeData(fontFamily: "Vazir"),
            home: const MainScreen(),
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _loading() {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
