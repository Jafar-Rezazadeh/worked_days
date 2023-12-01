import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';
import 'package:worked_days/bloc/services/get_list_of_status.dart';
import 'package:worked_days/ui/theme/color_schema.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/today_status/tear_down/get_today_status_new/widgets/in_out_time.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/today_status/tear_down/get_today_status_new/widgets/radio_buttons_of_status.dart';

class GetTodayStatusNewUI extends StatefulWidget {
  final Function onSubmit;
  const GetTodayStatusNewUI({super.key, required this.onSubmit});

  @override
  State<GetTodayStatusNewUI> createState() => _GetTodayStatusNewUIState();
}

class _GetTodayStatusNewUIState extends State<GetTodayStatusNewUI> {
  WorkDayModel todayStatusInfo = getListOfStatus().first;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          RadioButtonsOfTodayStatus(onChange: (value) => setState(() => todayStatusInfo = value)),
          if (todayStatusInfo.workDay) _inOutTime(),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: 0.6.sw,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: ColorPallet.green,
                width: 2,
              ),
            ),
          ),
        ),
        onPressed: () {},
        child: const Text("ذخیره"),
      ),
    );
  }

  Widget _inOutTime() {
    return Expanded(
      child: Column(
        children: [
          Divider(
            height: 20.sp,
            color: ColorPallet.yaleBlue.withOpacity(0.5),
            thickness: 1,
          ),
          const InOutTimeSelector(),
          Divider(
            height: 20.sp,
            color: ColorPallet.yaleBlue.withOpacity(0.5),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
