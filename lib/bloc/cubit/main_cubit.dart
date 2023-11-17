import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/bloc/entities/notification_pref_model.dart';
import 'package:worked_days/bloc/entities/salary_model.dart';
import 'package:worked_days/bloc/entities/settings_model.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';
import 'package:worked_days/data/local_database/db_provider.dart';
import 'package:worked_days/bloc/services/settings_service.dart';

class MainCubit extends Cubit<MainCubitState> {
  MainCubit() : super(MainCubitInitial()) {
    loadDataAndStartApp();
  }

  loadDataAndStartApp() async {
    emit(LoadingState());

    NotificationPrefModel notificationPrefModel = await SettingsService.getNotificationStatus();
    List<WorkDayModel> workedDaysData = await DbProvider().getWorkDays();
    int? defaultSalaryAmount = await SettingsService.getSalary();
    List<SalaryModel> storedSalaries = await DbProvider().getSalaries();

    // print(storedSalaries);

    emit(
      LoadedStableState(
        notificationSettings: notificationPrefModel,
        workedDays: workedDaysData,
        settingsModel: SettingsModel(salaryDefaultAmount: defaultSalaryAmount),
        salaries: storedSalaries,
      ),
    );
  }

  //? database
  insertWorkedDay(
      {required LoadedStableState loadedStableState, required WorkDayModel newWorkDayModel}) async {
    newWorkDayModel.id = await DbProvider().insertWorkDay(newWorkDayModel);

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
    await DbProvider().deleteWorkDay(id);

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

  insertSalary(
      {required SalaryModel salaryModel, required LoadedStableState loadedStableState}) async {
    List<SalaryModel> salaries = loadedStableState.salaries;

    salaries.removeWhere((element) => element.id == salaryModel.id);
    await DbProvider().deleteSalary(salaryModel.id);

    int id = await DbProvider().insertSalary(salaryModel);

    salaryModel.id = id;
    salaries.add(salaryModel);
    LoadedStableState newLoadedStableState = LoadedStableState(
      notificationSettings: loadedStableState.notificationSettings,
      salaries: salaries,
      settingsModel: loadedStableState.settingsModel,
      workedDays: loadedStableState.workedDays,
    );

    emit(newLoadedStableState);
  }

  //? notification
  setNotificationSettings(
      {required LoadedStableState loadedStableState, required NotificationPrefModel nS}) async {
    //

    await SettingsService.setNotificationStatus(notificationPrefModel: nS);

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
}
