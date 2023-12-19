import 'package:flutter/material.dart';

import '../../../../core/theme/color_schema.dart';

class SettingsLoadingPage extends StatelessWidget {
  const SettingsLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: ColorPallet.yaleBlue,
        ),
      ),
    );
  }
}
