import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/bloc/models/notification_pref_model.dart';
import 'package:worked_days/bloc/models/salary_model.dart';
import 'package:worked_days/bloc/models/settings_model.dart';
import 'package:worked_days/bloc/models/worked_day_model.dart';
import 'package:worked_days/data/db_provider_service.dart';
import 'package:worked_days/bloc/services/settings_service.dart';

class MainCubit extends Cubit<MainCubitState> {
  MainCubit() : super(MainCubitInitial());

  //?----------Events----------
  loadDataAndStartApp() async {
    emit(LoadingState());

    //? GettingData
    NotificationPrefModel notificationPrefModel = await SettingsService.getNotificationStatus();
    List<WorkDayModel> workedDaysData = await DataBaseHandlerService().getWorkDays();
    int defaultSalaryAmount = await SettingsService.getSalary();
    List<SalaryModel> storedSalaries = DataBaseHandlerService().getSalaries();

    emit(
      LoadedStableState(
        notificationSettings: notificationPrefModel,
        workedDays: workedDaysData,
        settingsModel: SettingsModel(salaryDefaultAmount: defaultSalaryAmount),
        salaries: storedSalaries,
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
      salaries: loadedStableState.salaries,
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
      salaries: loadedStableState.salaries,
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
      salaries: loadedStableState.salaries,
    );

    emit(newloadedStableState);
  }

  setDefaultSalaryAmount({int? salaryAmount, required LoadedStableState loadedStableState}) async {
    await SettingsService.setSalaryAmount(salaryAmount);

    LoadedStableState newloadedStableState = LoadedStableState(
      notificationSettings: loadedStableState.notificationSettings,
      workedDays: loadedStableState.workedDays,
      settingsModel: SettingsModel(
        salaryDefaultAmount: salaryAmount ?? 1,
      ),
      salaries: loadedStableState.salaries,
    );

    emit(newloadedStableState);
  }
  //* ----------tear down functions----------
}
