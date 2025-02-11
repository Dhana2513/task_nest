import 'package:dartz/dartz.dart';
import 'package:task_nest/domain/entity/task_entity.dart';

import '../../core/platform/usecase/params.dart';
import '../../core/platform/usecase/usecase.dart';

class FetchTasks extends UseCase<List<TaskEntity>, NoParam> {
  @override
  Future<Either<Failure, List<TaskEntity>?>> call(NoParam params) {
    throw UnimplementedError();
  }
}
