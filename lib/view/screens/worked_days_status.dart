import 'package:flutter/material.dart';
import 'package:worked_days/controller/today_page_controller.dart';
import 'package:worked_days/controller/worked_days_page_controller.dart';
import 'package:worked_days/model/color_schema.dart';
import 'package:worked_days/view/screens/main_screen.dart';
import 'package:worked_days/view/screens/settings_screen.dart';

class WorkedDaysStatusScreen extends StatefulWidget {
  const WorkedDaysStatusScreen({super.key});

  @override
  State<WorkedDaysStatusScreen> createState() => _WorkedDaysStatusScreenState();
}

class _WorkedDaysStatusScreenState extends State<WorkedDaysStatusScreen> {
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
        "Developed by Jafar.Rezazadeh ©",
        textAlign: TextAlign.center,
      ),
      titleTextStyle: TextStyle(
        fontSize: screenSize.width / 50,
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
        TodayStatusPageController(),
        WorkedDaysPageController(),
      ],
    );
  }

  _tabBar() {
    return PreferredSize(
      preferredSize: Size(
        double.infinity,
        screenSize.height / 10,
      ),
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
