import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/bloc/services/shamsi_formater_service.dart';
import 'package:worked_days/data/entities/color_schema.dart';
import 'package:worked_days/data/entities/worked_day_model.dart';

class DetailsWorkDay extends StatelessWidget {
  final WorkDayModel workDayModel;
  final LoadedStableState loadedStableState;
  const DetailsWorkDay({
    super.key,
    required this.workDayModel,
    required this.loadedStableState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallet.yaleBlue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 50.sp,
            vertical: 50,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //title
              _textContainer(title: "وضعیت", txt: workDayModel.title),
              //datetime
              const SizedBox(height: 20),
              _textContainer(
                title: "تاریخ",
                txt: ShamsiFormatterService.getTodayFullDateTime(workDayModel.dateTime),
                fontsizeMult: -2,
              ),
              const SizedBox(height: 20),
              //description
              _textContainer(
                title: "توضیح کوتاه",
                txt: workDayModel.shortDescription,
                goNextLineOfTitle: true,
              ),
              const SizedBox(height: 20),
              // in/out Time
              _textContainer(title: "ساعت ورود", txt: workDayModel.inTime),
              _textContainer(title: "ساعت خروج", txt: workDayModel.outTime),
              // return
              SizedBox(height: 150.sp),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50)),
                    backgroundColor: MaterialStatePropertyAll(ColorPallet.green),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("بازگشت"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _textContainer(
      {String? title, String? txt, bool goNextLineOfTitle = false, double fontsizeMult = 0}) {
    return RichText(
      overflow: TextOverflow.clip,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: TextStyle(
          fontSize: 20.sp,
          fontFamily: "Vazir",
        ),
        children: [
          TextSpan(
            text: goNextLineOfTitle ? "$title: \n" : "$title: ",
            style: TextStyle(
              color: ColorPallet.yaleBlue,
            ),
          ),
          TextSpan(
            text: txt != null ? " $txt" : " خالی",
            style: TextStyle(
              color: ColorPallet.orange,
              fontSize: 20.sp + fontsizeMult,
            ),
          ),
        ],
      ),
    );
  }
}
