import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';
import 'package:worked_days/bloc/services/get_list_of_status.dart';
import 'package:worked_days/ui/extentions/to_persian_period.dart';
import 'package:worked_days/ui/theme/color_schema.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/today_status/tear_down/get_today_status/widgets/in_out_time.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/today_status/tear_down/get_today_status/widgets/select_today_status.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/today_status/tear_down/get_today_status/widgets/short_description.dart';
import 'package:worked_days/ui/view/shared/widgets/custom_snackbar.dart';

class GetTodayStatusUi extends StatefulWidget {
  final DateTime? setCurrentTime;
  final Function(WorkDayModel) onSubmit;

  const GetTodayStatusUi({super.key, required this.onSubmit, this.setCurrentTime});

  @override
  State<GetTodayStatusUi> createState() => _GetTodayStatusUiState();
}

class _GetTodayStatusUiState extends State<GetTodayStatusUi> {
  WorkDayModel todayStatusInfo = getListOfStatus().first;

  @override
  void initState() {
    //setting the current time if it is set
    todayStatusInfo.dateTime = widget.setCurrentTime ?? todayStatusInfo.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 0.758.sh,
        padding: EdgeInsets.symmetric(vertical: 15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            SelectTodayStatus(onChange: (value) => setState(() => todayStatusInfo = value)),
            if (todayStatusInfo.workDay) ..._selectInOutTime(),
            GetDescription(onTextChanged: (value) => todayStatusInfo.shortDescription = value),
            _submitButton(),
          ],
        ),
      ),
    );
  }

  List<Widget> _selectInOutTime() {
    return [
      Divider(
        height: 20.sp,
        color: ColorPallet.yaleBlue.withOpacity(0.5),
        thickness: 1,
      ),
      InOutTimeSelector(onChange: (inTime, outTime) {
        todayStatusInfo.inTime = inTime?.format(context).toPersianPeriod;
        todayStatusInfo.outTime = outTime?.format(context).toPersianPeriod;
      }),
      Divider(
        height: 20.sp,
        color: ColorPallet.yaleBlue.withOpacity(0.5),
        thickness: 1,
      ),
    ];
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
        onPressed: () {
          if (todayStatusInfo.inTime != null && todayStatusInfo.outTime != null) {
            widget.onSubmit(todayStatusInfo);
          } else {
            showCustomSnackBar(
              context: context,
              text: "لطفا زمان ورود و خروج را مشخص کنید.",
            );
          }
        },
        child: const Text("ذخیره"),
      ),
    );
  }
}
