import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/ui/theme/color_schema.dart';

class MainThemeClass {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Vazir",
    colorScheme: ColorScheme.fromSeed(seedColor: ColorPallet.yaleBlue),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorPallet.yaleBlue,
    ),
    dataTableTheme: DataTableThemeData(
      headingTextStyle: TextStyle(
        fontSize: 13.sp,
        color: ColorPallet.yaleBlue,
        fontFamily: "Vazir",
      ),
      dataTextStyle: TextStyle(
        fontSize: 12.sp,
        color: Colors.black,
        fontFamily: "Vazir",
      ),
      headingRowColor: MaterialStatePropertyAll<Color>(
        ColorPallet.yaleBlue.withOpacity(0.2),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll<Color>(ColorPallet.smoke),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.yaleBlue),
        foregroundColor: MaterialStatePropertyAll<Color>(ColorPallet.smoke),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorPallet.orange,
    ),
  );
}
