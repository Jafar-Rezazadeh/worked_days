import 'package:flutter/material.dart';
import 'package:worked_days/ui/theme/color_schema.dart';

class MainThemeClass {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Vazir",
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorPallet.yaleBlue,
      primary: ColorPallet.yaleBlue,
      secondary: ColorPallet.orange,
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
