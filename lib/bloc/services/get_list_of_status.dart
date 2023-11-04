import 'package:worked_days/data/entities/worked_day_model.dart';

List<WorkDayModel> getListOfStatus() => [
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
