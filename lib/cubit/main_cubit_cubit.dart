import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/services/db_provider_service.dart';
import 'package:worked_days/services/settings_service.dart';

class MainCubit extends Cubit<MainCubitState> {
  MainCubit() : super(MainCubitInitial());

  //?----------Events----------
  loadDataAndStartApp() async {
    emit(LoadingState());

    //? GettingData
    NotificationPrefModel notificationPrefModel = await SettingsService.getShowNotificationsPref();
    List<WorkDayModel> workedDaysData = await DataBaseHandlerService().getWorkDays();

    //? wait for a moment to get the screensize and set the state
    await Future.delayed(const Duration(microseconds: 20));
    Size screenSize = MediaQueryData.fromView(PlatformDispatcher.instance.views.first).size;
    if (screenSize.width > 0) {
      emit(
        LoadedStableState(
          screenSize: screenSize,
          notificationSettings: notificationPrefModel,
          workedDays: workedDaysData,
        ),
      );
    }
  }

  insertWorkedDay(
      {required LoadedStableState loadedStableState, required WorkDayModel newWorkDayModel}) async {
    //? DataBase
    newWorkDayModel.id = await DataBaseHandlerService().insertWorkDay(newWorkDayModel);

    //? StateUpdates
    List<WorkDayModel> listOfWorkDaysData = loadedStableState.workedDays;

    listOfWorkDaysData.add(newWorkDayModel);

    LoadedStableState newloadedStableState = LoadedStableState(
      screenSize: loadedStableState.screenSize,
      workedDays: listOfWorkDaysData,
      notificationSettings: loadedStableState.notificationSettings,
    );

    emit(newloadedStableState);
  }

  deleteWorkDay({required int id, required LoadedStableState loadedStableState}) async {
    //? DataBase
    await DataBaseHandlerService().deleteWorkDay(id);

    //? StateUpdates
    List<WorkDayModel> listOfWorkDaysData = loadedStableState.workedDays;

    listOfWorkDaysData.removeWhere((element) => element.id == id);

    LoadedStableState newloadedStableState = LoadedStableState(
      screenSize: loadedStableState.screenSize,
      workedDays: listOfWorkDaysData,
      notificationSettings: loadedStableState.notificationSettings,
    );

    emit(newloadedStableState);
  }

  setNotificationSettings(
      {required LoadedStableState loadedStableState, required NotificationPrefModel nS}) async {
    //
    //? Set the notification settings
    await SettingsService.setNotificationPref(notificationPrefModel: nS);

    //? StateUpdates
    LoadedStableState newloadedStableState = LoadedStableState(
      screenSize: loadedStableState.screenSize,
      workedDays: loadedStableState.workedDays,
      notificationSettings: nS,
    );

    emit(newloadedStableState);
  }
  //* ----------tear down functions----------
}
