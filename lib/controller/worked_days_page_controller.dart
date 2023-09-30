import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/model/provide_data_model.dart';
import 'package:worked_days/view/page/worked_days_list/worked_days_list.dart';

class WorkedDaysPageController extends StatefulWidget {
  const WorkedDaysPageController({super.key});

  @override
  State<WorkedDaysPageController> createState() => _WorkedDaysPageControllerState();
}

class _WorkedDaysPageControllerState extends State<WorkedDaysPageController> {
  late ProviderDataModel providerDataModel;
  Jalali currentDateTime = Jalali.now();
  @override
  Widget build(BuildContext context) {
    providerDataModel = context.watch<ProviderDataModel>();
    return WorkedDaysListPage(
      context: context,
      currentDateTime: currentDateTime,
      listOfCurrentWorkedDays: _getCurrentSelectedDateWorkedDays(),
      onCureentDateTimeChanged: (value) {
        setState(() {
          currentDateTime = value;
        });
      },
    );
  }

  _getCurrentSelectedDateWorkedDays() {
    return providerDataModel.workedDays
        .where(
          (element) =>
              element.dateTime.toJalali().month == currentDateTime.month &&
              element.dateTime.toJalali().year == currentDateTime.year,
        )
        .toList();
  }
}
