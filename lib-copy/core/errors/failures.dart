import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class LocalDataFailure extends Failure {
  const LocalDataFailure({required super.message});
}

class UnExpectedFailure extends Failure {
  const UnExpectedFailure({required super.message});
}
