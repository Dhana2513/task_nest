import 'package:dartz/dartz.dart';

import 'package:task_nest/core/platform/failure.dart';
import 'package:task_nest/data/datasource/remote/task_remote_datasource.dart';

import 'package:task_nest/domain/entity/task_entity.dart';

import '../../domain/repoository/task_repository_protocol.dart';
import '../datasource/local/task_local_datasource.dart';

class TaskRepository implements TaskRepositoryProtocol {
  final TaskLocalDatasource taskDatasource;
  final TaskRemoteDatasource taskRemoteDatasource;

  TaskRepository({
    required this.taskDatasource,
    required this.taskRemoteDatasource,
  });

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
