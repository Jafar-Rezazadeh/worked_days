import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../core/theme/color_schema.dart';
import 'expandable_card_widget.dart';

class NotificationSettingsWidget extends StatefulWidget {
  final bool isActive;
  final TimeOfDay initialNotificationPeriodTime;
  final ValueChanged<bool> onActivateChanged;
  final ValueChanged<TimeOfDay> onNotificationTimeChanged;
  const NotificationSettingsWidget({
    super.key,
    required this.onActivateChanged,
    required this.isActive,
    required this.onNotificationTimeChanged,
    required this.initialNotificationPeriodTime,
  });

  @override
  State<NotificationSettingsWidget> createState() => _NotificationSettingsWidgetState();
}

class _NotificationSettingsWidgetState extends State<NotificationSettingsWidget> {
  late bool isActive;
  late TimeOfDay notificationPeriodTime;

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive;
    notificationPeriodTime = widget.initialNotificationPeriodTime;
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableCardWidget(
      header: "دریافت اعلان",
      collapsed: _collapsedWidget(),
      expanded: Column(
        children: [
          _setPeriodicNotificationTime(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _collapsedWidget() {
    return Align(
      alignment: Alignment.centerRight,
      child: Switch.adaptive(
        value: isActive,
        onChanged: (value) {
          setState(() => isActive = value);
          widget.onActivateChanged(value);
        },
      ),
    );
  }

  Widget _setPeriodicNotificationTime(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(20)),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: 1, color: ColorPallet.yaleBlue),
          ),
        ),
      ),
      onPressed: () async {
        await showPersianTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((value) {
          if (value != null) {
            setState(() {
              notificationPeriodTime = value;
            });
            widget.onNotificationTimeChanged(value);
          }
        });
      },
      child: Text(
        notificationPeriodTime.persianFormat(context),
        style: TextStyle(
          fontSize: 18.sp,
          color: ColorPallet.yaleBlue,
        ),
      ),
    );
  }
}
