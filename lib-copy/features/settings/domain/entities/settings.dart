import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final int? salaryAmountContract;

  const Settings({required this.salaryAmountContract});

  @override
  List<Object?> get props => [salaryAmountContract];
}
