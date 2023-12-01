import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/ui/theme/color_schema.dart';

class InOutTimeSelector extends StatefulWidget {
  const InOutTimeSelector({super.key});

  @override
  State<InOutTimeSelector> createState() => _InOutTimeSelectorState();
}

class _InOutTimeSelectorState extends State<InOutTimeSelector> {
  //Todo: add 2 option for selecting in and out time as right now or in a specific time
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _inOutLayout(
            child: ElevatedButton(
              style: _elevetedButtonStyle(backgroundColor: ColorPallet.green),
              onPressed: () {},
              child: const Text("زمان ورود"),
            ),
          ),
          Dash(
            length: 0.9.sw,
            dashColor: ColorPallet.yaleBlue.withOpacity(0.8),
          ),
          _inOutLayout(
            child: ElevatedButton(
              style: _elevetedButtonStyle(backgroundColor: ColorPallet.orange),
              onPressed: () {},
              child: const Text("زمان خروج"),
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
        child: SizedBox(
          width: 0.6.sw,
          child: child,
        ),
      ),
    );
  }

  ButtonStyle _elevetedButtonStyle({Color? foregroundColor, Color? backgroundColor}) {
    Color backgroundColor_ = backgroundColor ?? ColorPallet.green;
    Color foregroundColor_ = foregroundColor ?? ColorPallet.smoke;

    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor_),
      foregroundColor: MaterialStatePropertyAll<Color>(foregroundColor_),
    );
  }
}
