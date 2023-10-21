import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/model/color_schema.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/services/get_list_of_status.dart';
import 'package:worked_days/view/tabs/today_status/get_today_status_/widgets/select_today_status.dart';
import 'package:worked_days/view/tabs/today_status/get_today_status_/widgets/short_desc.dart';
import 'package:worked_days/view/tabs/today_status/get_today_status_/widgets/today_date_time.dart';
import 'package:worked_days/view/tabs/today_status/get_today_status_/widgets/work_time_select.dart';
import '../../../../extentions/my_extentions.dart';

class GetTodayStatusPage extends StatefulWidget {
  final ValueChanged<WorkDayModel> onSubmit;
  const GetTodayStatusPage({super.key, required this.onSubmit});

  @override
  State<GetTodayStatusPage> createState() => _GetTodayStatusPageState();
}

class _GetTodayStatusPageState extends State<GetTodayStatusPage>
    with AutomaticKeepAliveClientMixin {
  final List<WorkDayModel> listOfStatus = getListOfStatus();
  late MainCubit mainCubit;
  late LoadedStableState loadedStableState;
  late WorkDayModel status = listOfStatus.first;
  double fontSize = 17.sp;

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
            Title(
              color: ColorPallet.deepYellow,
              child: Text(
                "وضعیت امروز چیه؟",
                style: TextStyle(
                  fontSize: fontSize + 5,
                ),
              ),
            ),
            SizedBox(height: 10.sp),
            todayDateTime(fontSize),
            SizedBox(height: 25.sp),
            selectStatus(
              listOfStatus: listOfStatus,
              onChange: (value) => setState(() => status = value),
              fontSize: fontSize,
            ),
            SizedBox(height: 20.sp),
            workTimeSelect(
              context: context,
              onInTimechanged: (value) => setState(() {
                radioGroupValue = value!;
                error = false;
              }),
              onOutTimechanged: (value) => setState(() => radioGroupValue = value!),
              radioGroupValue: radioGroupValue,
              onInTimeChoosed: (value) => setState(() => inTime = value),
              onOutTimeChoosed: (value) => setState(() => outTime = value),
              inTime: inTime,
              outTime: outTime,
              error: error,
              status: status,
            ),
            SizedBox(height: 20.sp),
            addShortDescription(
              onInputChanged: (value) => shortDescription = value,
              status: status,
            ),
            _submit(),
          ],
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

  @override
  bool get wantKeepAlive => true;
}
