import 'package:dartz/dartz.dart';

import '../../platform/failure.dart';
import 'params.dart';

export '../../platform/failure.dart';

abstract class UseCase<T, P extends Params> {
  Future<Either<Failure, T?>> call(P params);
}
