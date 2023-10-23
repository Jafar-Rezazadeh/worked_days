import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/models/notification_pref_model.dart';
import 'package:worked_days/models/salary_model.dart';
import 'package:worked_days/models/settings_model.dart';
import 'package:worked_days/models/worked_day_model.dart';
import 'package:worked_days/services/db_provider_service.dart';
import 'package:worked_days/services/settings_service.dart';

class MainCubit extends Cubit<MainCubitState> {
  MainCubit() : super(MainCubitInitial());

  //?----------Events----------
  loadDataAndStartApp() async {
    emit(LoadingState());

    //? GettingData
    NotificationPrefModel notificationPrefModel = await SettingsService.getNotificationStatus();
    List<WorkDayModel> workedDaysData = await DataBaseHandlerService().getWorkDays();

    SalaryModel salaryModel = await SettingsService.getSalary();

    emit(
      LoadedStableState(
        notificationSettings: notificationPrefModel,
        workedDays: workedDaysData,
        settingsModel: SettingsModel(salaryModel: salaryModel),
      ),
    );
  }

  insertWorkedDay(
      {required LoadedStableState loadedStableState, required WorkDayModel newWorkDayModel}) async {
    //? DataBase
    newWorkDayModel.id = await DataBaseHandlerService().insertWorkDay(newWorkDayModel);

    //? StateUpdates
    List<WorkDayModel> listOfWorkDaysData = loadedStableState.workedDays;

    listOfWorkDaysData.add(newWorkDayModel);

    LoadedStableState newloadedStableState = LoadedStableState(
      workedDays: listOfWorkDaysData,
      notificationSettings: loadedStableState.notificationSettings,
      settingsModel: loadedStableState.settingsModel,
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
      workedDays: listOfWorkDaysData,
      notificationSettings: loadedStableState.notificationSettings,
      settingsModel: loadedStableState.settingsModel,
    );

    emit(newloadedStableState);
  }

  setNotificationSettings(
      {required LoadedStableState loadedStableState, required NotificationPrefModel nS}) async {
    //
    //? Set the notification settings
    await SettingsService.setNotificationStatus(notificationPrefModel: nS);

    //? StateUpdates
    LoadedStableState newloadedStableState = LoadedStableState(
      workedDays: loadedStableState.workedDays,
      notificationSettings: nS,
      settingsModel: loadedStableState.settingsModel,
    );

    emit(newloadedStableState);
  }

  setSalaryAmount({int? salaryAmount, required LoadedStableState loadedStableState}) async {
    await SettingsService.setSalaryAmount(salaryAmount);

    LoadedStableState newloadedStableState = LoadedStableState(
      notificationSettings: loadedStableState.notificationSettings,
      workedDays: loadedStableState.workedDays,
      settingsModel: SettingsModel(salaryModel: SalaryModel(salaryAmount: salaryAmount)),
    );

    emit(newloadedStableState);
  }
  //* ----------tear down functions----------
}
