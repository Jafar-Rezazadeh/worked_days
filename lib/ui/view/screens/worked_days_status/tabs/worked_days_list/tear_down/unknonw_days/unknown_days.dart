import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_screen/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/ui/theme/color_schema.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/worked_days_list/tear_down/unknonw_days/widgets/select_unknown_day.dart';

class UnknownDays extends StatelessWidget {
  final WorkedDaysTabController workedDaysTabController;

  const UnknownDays({
    super.key,
    required this.workedDaysTabController,
  });

  @override
  Widget build(BuildContext context) {
    List<Jalali> unknownDays = workedDaysTabController.extractUnknownDaysOfCurrentMonth();
    return unknownDays.isNotEmpty
        ? Expanded(
            flex: 1,
            child: Container(
              color: ColorPallet.orange,
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: ColorPallet.yaleBlue),
                    "روزهای نامشخص ${unknownDays.length} روز",
                  ),
                  SizedBox(
                    height: 30.sp,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SelectUnknownDay(
                            unknownDaysDateTime: unknownDays,
                            workedDaysTabController: workedDaysTabController,
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return ColorPallet.yaleBlue.withOpacity(0.5);
                          } else {
                            return ColorPallet.yaleBlue;
                          }
                        }),
                        foregroundColor: MaterialStatePropertyAll<Color>(ColorPallet.smoke),
                      ),
                      child: const Text("تأیین وضعیت"),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
