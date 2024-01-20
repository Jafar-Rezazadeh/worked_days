import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit/settings_cubit.dart';
import 'error_page.dart';
import 'settings_loaded_page.dart';
import 'loading_page.dart';

class SettingsMainPage extends StatefulWidget {
  const SettingsMainPage({super.key});

  @override
  State<SettingsMainPage> createState() => _SettingsMainPageState();
}

class _SettingsMainPageState extends State<SettingsMainPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsCubit>(context).getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoadingState) {
          return const SettingsLoadingPage();
        }
        if (state is SettingsLoadedState) {
          return SettingsLoadedPage(settings: state.settings);
        }
        if (state is SettingsErrorState) {
          return SettingsErrorPage(errorMessage: state.errorMessage);
        } else {
          return const Scaffold(
            body: Center(
              child: Text("unknown sate "),
            ),
          );
        }
      },
    );
  }
}
