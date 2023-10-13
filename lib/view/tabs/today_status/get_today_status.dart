import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:worked_days/controller/shamsi_formater.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/model/color_schema.dart';
import 'package:worked_days/model/worked_day_model.dart';
import '../../../extentions/my_extentions.dart';

class GetTodayStatusPage extends StatefulWidget {
  final ValueChanged<WorkDayModel> onSubmit;
  const GetTodayStatusPage({super.key, required this.onSubmit});

  @override
  State<GetTodayStatusPage> createState() => _GetTodayStatusPageState();
}

class _GetTodayStatusPageState extends State<GetTodayStatusPage>
    with AutomaticKeepAliveClientMixin {
  final List<WorkDayModel> listOfStatus = [
    WorkDayModel(
      id: 0,
      title: "کار کردم",
      dateTime: DateTime.now(),
      shortDescription: null,
      inTime: null,
      outTime: null,
      workDay: true,
      dayOff: false,
      publicHoliday: false,
    ),
    WorkDayModel(
      id: 1,
      title: "تعطیل رسمی",
      dateTime: DateTime.now(),
      shortDescription: null,
      inTime: null,
      outTime: null,
      workDay: false,
      dayOff: false,
      publicHoliday: true,
    ),
    WorkDayModel(
      id: 2,
      title: "تعطیل",
      dateTime: DateTime.now(),
      shortDescription: null,
      inTime: null,
      outTime: null,
      workDay: false,
      dayOff: true,
      publicHoliday: false,
    ),
  ];
  late MainCubit mainCubit;
  late LoadedStableState loadedStableState;
  late WorkDayModel status = listOfStatus.first;
  double fontSize = 13.sp;

  double workTimeSelectFontSize = 14.sp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getState();
  }

  _getState() {
    mainCubit = BlocProvider.of<MainCubit>(context, listen: true);
    if (mainCubit.state is LoadedStableState) {
      loadedStableState = mainCubit.state as LoadedStableState;
    }
  }

  int radioGroupValue = 0;
  TimeOfDay? inTime;
  TimeOfDay? outTime;
  String? shortDescription;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _title(),
            SizedBox(height: 10.sp),
            _todayDateTime(),
            SizedBox(height: 25.sp),
            _selectStatus(),
            SizedBox(height: 20.sp),
            _workTimeSelect(),
            SizedBox(height: 20.sp),
            _addShortDescription(),
            _submit(),
          ],
        ),
      ),
    );
  }

  _selectStatus() {
    return SizedBox(
      height: 50.sp,
      child: CustomRadioButton(
        height: 50,
        buttonLables: const [
          "کار کردم",
          "تعطیل رسمی",
          "تعطیل",
        ],
        buttonValues: listOfStatus,
        radioButtonValue: (value) => setState(() => status = value),
        selectedBorderColor: ColorPallet.orange,
        unSelectedBorderColor: ColorPallet.yaleBlue,
        unSelectedColor: ColorPallet.smoke,
        selectedColor: ColorPallet.yaleBlue,
        defaultSelected: listOfStatus.first,
        enableShape: true,
        shapeRadius: 5,
        radius: 5,
        elevation: 0,
        buttonTextStyle: ButtonTextStyle(
          textStyle: TextStyle(
            fontSize: fontSize / 1.1,
          ),
        ),
      ),
    );
  }

  _submit() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(ColorPallet.yaleBlue),
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        )),
      ),
      onPressed: () => handleSubmit(),
      child: Text(
        "ذخیره",
        style: TextStyle(
          fontSize: fontSize + 2,
        ),
      ),
    )
        .animate(target: status.id == 0 || status.id == 2 ? 0 : 1)
        .then(delay: 410.milliseconds)
        .slideY(
          begin: 0,
          end: -4,
          duration: 400.milliseconds,
          curve: Curves.easeInOutExpo,
        );
  }

  _title() {
    return Title(
      color: ColorPallet.deepYellow,
      child: Text(
        "وضعیت امروز چیه؟",
        style: TextStyle(
          fontSize: fontSize + 5,
        ),
      ),
    );
  }

  _todayDateTime() {
    return Text(
      ShamsiFormatter.getTodayFullDateTime(null),
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }

  _workTimeSelect() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: 300.sp,
      decoration: BoxDecoration(
        color: ColorPallet.smoke,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          RadioListTile(
            fillColor: MaterialStatePropertyAll(ColorPallet.yaleBlue),
            value: 0,
            groupValue: radioGroupValue,
            onChanged: (value) => setState(() {
              radioGroupValue = value!;
              error = false;
            }),
            secondary: Row(
              textDirection: TextDirection.rtl,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _regularText(
                    const TimeOfDay(hour: 8, minute: 00).format(context).toPersionPeriod,
                    ColorPallet.orange,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _regularText("الی", null),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _regularText(
                    const TimeOfDay(hour: 18, minute: 00).format(context).toPersionPeriod,
                    ColorPallet.orange,
                  ),
                ),
              ],
            ),
          ),
          RadioListTile(
            fillColor: MaterialStatePropertyAll(ColorPallet.yaleBlue),
            value: 1,
            groupValue: radioGroupValue,
            onChanged: (value) {
              setState(() {
                radioGroupValue = value!;
              });
            },
            secondary: Row(
              textDirection: TextDirection.rtl,
              mainAxisSize: MainAxisSize.min,
              children: [
                selectInTime(),
                const SizedBox(width: 5),
                _regularText("الی", null),
                const SizedBox(width: 5),
                selectOutTime(),
              ],
            ),
          ),
          error && radioGroupValue == 1
              ? Container(child: _regularText("لطفا زمان ورود و خروج را انتخاب کنید", Colors.red))
                  .animate(target: error && radioGroupValue == 1 ? 1 : 0)
                  .fade(begin: 0, end: 1)
              : Container()
        ],
      ),
    ).animate(target: status.id == 0 ? 1 : 0).scaleY(
          begin: 0,
          end: 1,
          alignment: Alignment.topCenter,
          duration: 400.milliseconds,
          delay: 0.microseconds,
          curve: Curves.easeInOutExpo,
        );
  }

  @override
  bool get wantKeepAlive => true;

  selectInTime() {
    return TextButton(
      style: _textButtonStyle(),
      onPressed: radioGroupValue == 1
          ? () async {
              await showPersianTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 8, minute: 00),
              ).then((value) => setState(() => inTime = value));
            }
          : null,
      child:
          inTime != null ? Text(inTime!.format(context).toPersionPeriod) : const Text("زمان ورود"),
    );
  }

  selectOutTime() {
    return TextButton(
      style: _textButtonStyle(),
      onPressed: radioGroupValue == 1
          ? () async {
              await showPersianTimePicker(
                      context: context, initialTime: const TimeOfDay(hour: 18, minute: 00))
                  .then((value) => setState(() => outTime = value));
            }
          : null,
      child: outTime != null
          ? Text(outTime!.format(context).toPersionPeriod)
          : const Text("زمان خروج"),
    );
  }

  handleSubmit() {
    status.shortDescription = shortDescription;
    isWorkedDay() ? setInOutTime() : widget.onSubmit(status);
  }

  bool isWorkedDay() {
    return status.id == listOfStatus.first.id;
  }

  bool isCustomInOutTime() {
    return radioGroupValue == 1;
  }

  void setInOutTime() {
    isCustomInOutTime()
        ? {
            if (inTime != null && outTime != null)
              {
                status.inTime = inTime!.format(context).toPersionPeriod,
                status.outTime = outTime!.format(context).toPersionPeriod,
                widget.onSubmit(status),
                setState(() => error = false)
              }
            else
              {
                setState(() => error = true),
              }
          }
        : {
            status.inTime = const TimeOfDay(hour: 8, minute: 00).format(context).toPersionPeriod,
            status.outTime = const TimeOfDay(hour: 18, minute: 00).format(context).toPersionPeriod,
            widget.onSubmit(status)
          };
  }

  _textButtonStyle() {
    return ButtonStyle(
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 9)),
      textStyle: MaterialStatePropertyAll(TextStyle(
        fontFamily: "Vazir",
        fontSize: workTimeSelectFontSize,
      )),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          } else {
            return ColorPallet.yaleBlue;
          }
        },
      ),
      shape: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        } else {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(width: 1, color: ColorPallet.deepYellow),
          );
        }
      }),
    );
  }

  _addShortDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: 0.6.sw,
        child: TextField(
          onChanged: (value) => shortDescription = value,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: "توضیح کوتاه",
            hintStyle: TextStyle(fontSize: 13.sp),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(10),
          ),
          style: TextStyle(fontSize: 13.sp),
        ),
      ),
    ).animate(target: status.id == 0 || status.id == 2 ? 1 : 0).scaleY(
          begin: 0,
          end: 1,
          alignment: Alignment.topCenter,
          duration: 400.milliseconds,
          delay: 0.microseconds,
          curve: Curves.easeInOutExpo,
        );
  }

  _regularText(String txt, Color? color) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: workTimeSelectFontSize,
        color: color,
      ),
    );
  }
}
