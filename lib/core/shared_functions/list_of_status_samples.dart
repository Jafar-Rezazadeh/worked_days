import '../../features/work_days/domain/entities/work_days.dart';

List<WorkDay> getListOfStatus(DateTime? date) => [
      WorkDay(
        id: 0,
        title: "کار کردم",
        date: date ?? DateTime.now(),
        shortDescription: null,
        inTime: null,
        outTime: null,
        isWorkDay: true,
        isDayOff: false,
        isPublicHoliday: false,
      ),
      WorkDay(
        id: 1,
        title: "تعطیل رسمی",
        date: date ?? DateTime.now(),
        shortDescription: null,
        inTime: null,
        outTime: null,
        isWorkDay: false,
        isDayOff: false,
        isPublicHoliday: true,
      ),
      WorkDay(
        id: 2,
        title: "تعطیل",
        date: date ?? DateTime.now(),
        shortDescription: null,
        inTime: null,
        outTime: null,
        isWorkDay: false,
        isDayOff: true,
        isPublicHoliday: false,
      ),
    ];
