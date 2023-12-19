import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color_schema.dart';
import '../../../settings/presentation/cubit/cubit/settings_cubit.dart';
import '../../../settings/presentation/pages/settings_page_main.dart';

AppBar appBar(BuildContext context) {
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
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<SettingsCubit>(context),
                  child: const SettingsMainPage(),
                ),
              ),
            );
          },
          icon: const Icon(Icons.settings),
        ),
      ),
    ],
    bottom: _tabBar(),
  );
}

_tabBar() {
  tabTextStyle() {
    return TextStyle(
      color: ColorPallet.smoke,
    );
  }

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
            style: tabTextStyle(),
          ),
        ),
        Tab(
          height: 50,
          child: Text(
            "لیست روز های کاری",
            style: tabTextStyle(),
          ),
        ),
      ],
    ),
  );
}
