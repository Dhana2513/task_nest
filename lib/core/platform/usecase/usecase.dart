import 'package:dartz/dartz.dart';

import '../../platform/failure.dart';
import '../data_object.dart';
import 'params.dart';

export '../../platform/failure.dart';

abstract class UseCase<T, P extends Params> {
  Future<Either<Failure, T?>> call(P params);

  Either<Failure, T> foldedData(DataObject<T>? data) => data?.data != null
      ? Right(data!.data as T)
      : Left(data?.failure ?? Failure());
}
