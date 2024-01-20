import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:worked_days/features/work_days/domain/entities/work_day_temp.dart';

import '../../../../core/theme/color_schema.dart';
import '../../../../core/utils/extentions.dart';

class InOutTimeSelector extends StatefulWidget {
  final Function(TimeOfDay? inTime, TimeOfDay? outTime) onChange;
  final WorkDayTemporary? workDayTemporary;
  const InOutTimeSelector({super.key, required this.onChange, required this.workDayTemporary});

  @override
  State<InOutTimeSelector> createState() => _InOutTimeSelectorState();
}

class _InOutTimeSelectorState extends State<InOutTimeSelector> {
  TimeOfDay? inTime;
  TimeOfDay? outTime;

  @override
  void initState() {
    inTime = widget.workDayTemporary?.inTime;
    outTime = widget.workDayTemporary?.outTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //In Time
          _inOutLayout(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "زمان ورود",
                  style: TextStyle(
                    color: ColorPallet.smoke,
                  ),
                ),
                inTime == null
                    ? _inTimeGetters()
                    : Text(
                        inTime!.format(context).toPersianPeriod,
                        style: TextStyle(
                          color: ColorPallet.green,
                          fontSize: 30.sp,
                        ),
                      )
              ],
            ),
          ),
          //
          Dash(
            length: 0.9.sw,
            dashColor: ColorPallet.yaleBlue.withOpacity(0.8),
          ),
          //
          //Out time
          _inOutLayout(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "زمان خروج",
                  style: TextStyle(
                    color: ColorPallet.smoke,
                  ),
                ),
                outTime == null
                    ? _outTimeGetters()
                    : Text(
                        outTime!.format(context).toPersianPeriod,
                        style: TextStyle(
                          color: ColorPallet.orange,
                          fontSize: 30.sp,
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _inOutLayout({required Widget child}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.sp),
        child: Container(
          decoration: BoxDecoration(
            color: ColorPallet.yaleBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          width: 0.8.sw,
          child: child,
        ),
      ),
    );
  }

  ButtonStyle _elevetedButtonStyle({Color? foregroundColor, Color? backgroundColor}) {
    return ButtonStyle(
      textStyle: MaterialStatePropertyAll<TextStyle>(
        TextStyle(
          fontSize: 12.sp,
          fontFamily: "Vazir",
        ),
      ),
      backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor ?? ColorPallet.green),
      foregroundColor: MaterialStatePropertyAll<Color>(foregroundColor ?? ColorPallet.smoke),
    );
  }

  Widget _inTimeGetters() {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Right Now
        ElevatedButton(
          style: _elevetedButtonStyle(backgroundColor: ColorPallet.green),
          onPressed: () {
            setState(() => inTime = TimeOfDay.now());
            widget.onChange(inTime, outTime);
          },
          child: const Text("!همین الان"),
        ),
        // Another Time
        ElevatedButton(
          style: _elevetedButtonStyle(backgroundColor: Colors.transparent),
          onPressed: () async {
            await showPersianTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then(
              (value) {
                setState(() => inTime = value);
                widget.onChange(inTime, outTime);
              },
            );
          },
          child: const Text("...ساعت دیگه"),
        ),
      ],
    );
  }

  Widget _outTimeGetters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      textDirection: TextDirection.rtl,
      children: [
        // Right now
        ElevatedButton(
          style: _elevetedButtonStyle(backgroundColor: ColorPallet.orange),
          onPressed: () {
            setState(() => outTime = TimeOfDay.now());
            widget.onChange(inTime, outTime);
          },
          child: const Text("!همین الان"),
        ),
        // Another Time
        ElevatedButton(
          style: _elevetedButtonStyle(backgroundColor: Colors.transparent),
          onPressed: () async {
            await showPersianTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then(
              (value) {
                setState(() => outTime = value);
                widget.onChange(inTime, outTime);
              },
            );
          },
          child: const Text("...ساعت دیگه"),
        ),
      ],
    );
  }
}
