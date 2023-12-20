import 'package:flutter/material.dart';

ScaffoldFeatureController showCustomSnackBar({
  required BuildContext context,
  required String? text,
}) {
  return ScaffoldMessenger.maybeOf(context)!.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Center(
        child: Text(
          text ?? "",
          textDirection: TextDirection.rtl,
        ),
      ),
    ),
  );
}
