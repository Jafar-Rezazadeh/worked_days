import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/entities/color_schema.dart';

class UnknownDays extends StatelessWidget {
  const UnknownDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              style: TextStyle(
                color: ColorPallet.yaleBlue,
              ),
              "روزهای نامشخص" " 7" " روز",
            ),
            SizedBox(
              height: 30.sp,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.yaleBlue),
                    foregroundColor: MaterialStatePropertyAll<Color>(ColorPallet.smoke)),
                child: const Text("تأیین وضعیت"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
