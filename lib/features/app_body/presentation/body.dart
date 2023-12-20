import 'package:flutter/material.dart';
import '../../work_days/presentation/pages/workdays_main_page.dart';
import 'widgets/appbar.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar(context),
        body: const WorkDaysMainPage(),
      ),
    );
  }
}
