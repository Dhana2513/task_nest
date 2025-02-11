import 'package:dartz/dartz.dart';

import 'package:task_nest/core/platform/failure.dart';

import 'package:task_nest/domain/entity/task_entity.dart';

abstract class TaskRemoteDatasourceProtocol {
  Future<Either<Failure, List<TaskEntity>>> fetchTasks();

  Future<Either<Failure, bool>> createTask(TaskEntity taskModel);

  Future<Either<Failure, bool>> updateTask(TaskEntity taskModel);

  Future<Either<Failure, bool>> deleteTask(TaskEntity taskModel);
}

class TaskRemoteDatasource implements TaskRemoteDatasourceProtocol {
  @override
  Future<Either<Failure, bool>> createTask(TaskEntity taskModel) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteTask(TaskEntity taskModel) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks() {
    // TODO: implement fetchTasks
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateTask(TaskEntity taskModel) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
