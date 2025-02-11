import 'package:dartz/dartz.dart';

import '../../core/platform/failure.dart';
import '../../domain/entity/task_entity.dart';

abstract class TaskDatasourceProtocol {
  Future<Either<Failure, List<TaskEntity>>> fetchTasks();

  Future<Either<Failure, bool>> createTask(TaskEntity taskModel);

  Future<Either<Failure, bool>> updateTask(TaskEntity taskModel);

  Future<Either<Failure, bool>> deleteTask(TaskEntity taskModel);
}
