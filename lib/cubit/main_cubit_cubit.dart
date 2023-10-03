import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/services/db_provider_service.dart';
import 'package:worked_days/services/settings_service.dart';

class MainCubit extends Cubit<MainCubitState> {
  MainCubit() : super(MainCubitInitial());

  //?
  loadDataAndStartApp() async {
    Size screenSize = PlatformDispatcher.instance.views.first.physicalSize /
        PlatformDispatcher.instance.views.first.devicePixelRatio;

    emit(LoadingState());

    await Future.delayed(const Duration(seconds: 1));
    NotificationPrefModel notificationPrefModel = await SettingsService.getShowNotificationsPref();
    List<WorkDayModel> workedDaysData = await DataBaseHandlerService().getWorkDays();
    emit(
      LoadedStableState(
        screenSize: screenSize,
        notificationSettings: notificationPrefModel,
        workedDays: workedDaysData,
      ),
    );
  }

  //?
  insertWorkedDay({
    required LoadedStableState loadedStableState,
    required WorkDayModel newWorkDayModel,
  }) async {
    newWorkDayModel.id = await DataBaseHandlerService().insertWorkDay(newWorkDayModel);
    List<WorkDayModel> listOfWorkDaysData = loadedStableState.workedDays;

    listOfWorkDaysData.add(newWorkDayModel);

    LoadedStableState newloadedStableState = LoadedStableState(
      screenSize: loadedStableState.screenSize,
      workedDays: listOfWorkDaysData,
      notificationSettings: loadedStableState.notificationSettings,
    );

    emit(newloadedStableState);
  }

  //?
  deleteWorkDay({required int id, required LoadedStableState loadedStableState}) async {
    await DataBaseHandlerService().deleteWorkDay(id);
    List<WorkDayModel> listOfWorkDaysData = loadedStableState.workedDays;

    listOfWorkDaysData.removeWhere((element) => element.id == id);

    LoadedStableState newloadedStableState = LoadedStableState(
      screenSize: loadedStableState.screenSize,
      workedDays: listOfWorkDaysData,
      notificationSettings: loadedStableState.notificationSettings,
    );

    emit(newloadedStableState);
  }

  //?
  setNotificationSettings({
    required LoadedStableState loadedStableState,
    required NotificationPrefModel nS,
  }) async {
    //

    await SettingsService.setNotificationPref(notificationPrefModel: nS);

    LoadedStableState newloadedStableState = LoadedStableState(
      screenSize: loadedStableState.screenSize,
      workedDays: loadedStableState.workedDays,
      notificationSettings: nS,
    );

    emit(newloadedStableState);
  }
}
