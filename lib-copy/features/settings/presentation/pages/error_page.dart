import 'package:flutter/material.dart';

class SettingsErrorPage extends StatelessWidget {
  final String errorMessage;
  const SettingsErrorPage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
