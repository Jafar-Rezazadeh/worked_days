import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract class UseCaseContract<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
