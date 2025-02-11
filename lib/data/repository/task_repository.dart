import 'package:dartz/dartz.dart';

import 'package:task_nest/core/platform/failure.dart';
import 'package:task_nest/data/datasource/remote/task_remote_datasource.dart';

import 'package:task_nest/domain/entity/task_entity.dart';

import '../../domain/repository/task_repository_protocol.dart';
import '../datasource/local/task_local_datasource.dart';

class TaskRepository implements TaskRepositoryProtocol {
  final TaskLocalDatasourceProtocol localDatasource;
  final TaskRemoteDatasourceProtocol remoteDatasource;

  TaskRepository({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks() {
    return localDatasource.fetchTasks();
  }

  @override
  Future<Either<Failure, bool>> createTask(TaskEntity taskModel) {
    return localDatasource.createTask(taskModel);
  }

  @override
  Future<Either<Failure, bool>> deleteTask(TaskEntity taskModel) {
    return localDatasource.deleteTask(taskModel);
  }

  @override
  Future<Either<Failure, bool>> updateTask(TaskEntity taskModel) {
    return localDatasource.updateTask(taskModel);
  }
}
