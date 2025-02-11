import 'package:dartz/dartz.dart';
import 'package:task_nest/core/platform/usecase/usecase.dart';
import 'package:task_nest/domain/usecase/params/params.dart';

class CreateTask extends UseCase<bool, TaskParams> {
  @override
  Future<Either<Failure, bool?>> call(TaskParams params) {
    throw UnimplementedError();
  }
}
