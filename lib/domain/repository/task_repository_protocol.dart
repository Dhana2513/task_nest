import 'package:dartz/dartz.dart';
import 'package:task_nest/domain/entity/task_entity.dart';

import '../../core/platform/failure.dart';

abstract class TaskRepositoryProtocol {
  Future<Either<Failure, List<TaskEntity>>> fetchTasks();

  Future<Either<Failure, bool>> createTask(TaskEntity task);

  Future<Either<Failure, bool>> updateTask(TaskEntity task);

  Future<Either<Failure, bool>> deleteTask(TaskEntity task);

  Future<Either<Failure, List<TaskEntity>>> syncTasks();
}
