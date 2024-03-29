import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/features/work_days/domain/entities/work_day_temp.dart';

import '../../../../../../core/shared_functions/list_of_status_samples.dart';
import '../../../../../../core/theme/color_schema.dart';
import '../../../../domain/entities/work_days.dart';
import '../../../bloc/cubit/workdays_cubit.dart';
import '../../../widgets/get_description.dart';
import '../../../widgets/in_out_time_selector.dart';
import '../../../widgets/select_today_status.dart';

class GetTodayStatus extends StatefulWidget {
  final DateTime? currentDate;
  final Function? onSubmit;
  final WorkDayTemporary? workDayTemporary;

  const GetTodayStatus(
      {super.key, this.currentDate, this.onSubmit, required this.workDayTemporary});

  @override
  State<GetTodayStatus> createState() => _GetTodayStatusUiState();
}

class _GetTodayStatusUiState extends State<GetTodayStatus> {
  late WorkDay todayStatusInfo = getListOfStatus(widget.currentDate).first;

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
            SelectTodayStatus(
              onChange: (value) => setState(() => todayStatusInfo = value),
              currentDate: widget.currentDate,
            ),
            if (todayStatusInfo.isWorkDay) ..._selectInOutTime(),
            GetDescription(onTextChanged: (value) => todayStatusInfo.shortDescription = value),
            if (!todayStatusInfo.isWorkDay) _submitButton(),
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
      InOutTimeSelector(
        workDayTemporary: widget.workDayTemporary,
        onChange: (inTime, outTime) {
          todayStatusInfo.inTime = inTime;
          todayStatusInfo.outTime = outTime;

          BlocProvider.of<WorkdaysCubit>(context).insertWorkDay(todayStatusInfo);

          if (todayStatusInfo.inTime != null && todayStatusInfo.outTime != null) {
            widget.onSubmit!();
          }
        },
      ),
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
          BlocProvider.of<WorkdaysCubit>(context).insertWorkDay(todayStatusInfo);
          if (widget.onSubmit != null) {
            widget.onSubmit!();
          }
        },
        child: const Text("ذخیره"),
      ),
    );
  }
}
