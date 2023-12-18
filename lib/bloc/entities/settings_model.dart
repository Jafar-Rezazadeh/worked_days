import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  final int? salaryDefaultAmount;

  const SettingsModel({required this.salaryDefaultAmount});

  @override
  List<Object?> get props => [salaryDefaultAmount];
}
