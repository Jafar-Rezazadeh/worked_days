import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';

class MainCubit extends Cubit<MainCubitState> {
  MainCubit() : super(MainCubitInitial());

  loadDataAndStartApp() async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(LoadedStableState());
  }
}
