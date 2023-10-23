import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/controller/screens/worked_days_status_c/today_status_controller.dart';
import 'package:worked_days/controller/screens/worked_days_status_c/work_day_list_controller.dart';
import 'package:worked_days/cubit/main_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/models/color_schema.dart';
import 'package:worked_days/view/screens/settings/settings_screen.dart';

class WorkedDaysStatusScreen extends StatefulWidget {
  const WorkedDaysStatusScreen({super.key});

  @override
  State<WorkedDaysStatusScreen> createState() => _WorkedDaysStatusScreenState();
}

class _WorkedDaysStatusScreenState extends State<WorkedDaysStatusScreen> {
  late MainCubit mainCubit;
  late LoadedStableState loadedStableState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getState();
  }

  void _getState() {
    mainCubit = BlocProvider.of<MainCubit>(context, listen: true);
    if (mainCubit.state is LoadedStableState) {
      loadedStableState = mainCubit.state as LoadedStableState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: ColorPallet.smoke,
          appBar: _appBar(),
          body: _tabView(),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorPallet.yaleBlue,
      centerTitle: true,
      title: const Text(
        "Developed by Jafar.Rezazadeh.",
        textAlign: TextAlign.center,
      ),
      titleTextStyle: TextStyle(
        fontSize: 6.5.sp,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            ),
            icon: const Icon(Icons.settings),
          ),
        ),
      ],
      bottom: _tabBar(),
    );
  }

  _tabView() {
    return const TabBarView(
      children: [
        TodayStatusTabController(),
        WorkedDaysTabController(),
      ],
    );
  }

  _tabBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 75.sp),
      child: TabBar(
        indicatorColor: ColorPallet.orange,
        indicatorWeight: 4,
        tabs: [
          Tab(
            height: 50,
            child: Text(
              "وضعیت امروز",
              style: _tabTextStyle(),
            ),
          ),
          Tab(
            height: 50,
            child: Text(
              "لیست روز های کاری",
              style: _tabTextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  _tabTextStyle() {
    return TextStyle(
      color: ColorPallet.smoke,
    );
  }
}
