import 'package:dartz/dartz.dart';

import 'package:task_nest/core/platform/failure.dart';
import 'package:task_nest/core/platform/local_database.dart';
import 'package:task_nest/data/datasource/remote/task_remote_datasource.dart';

import 'package:task_nest/domain/entity/task_entity.dart';

import '../../domain/repository/task_repository_protocol.dart';
import '../datasource/local/task_local_datasource.dart';
import '../model/task_model.dart';

class TaskRepository implements TaskRepositoryProtocol {
  final TaskLocalDatasourceProtocol localDatasource;
  final TaskRemoteDatasourceProtocol remoteDatasource;

  TaskRepository({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  Future<bool> get isOfflineMode => LocalDatabase.instance.isOffline;

  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks() async {
    if (await isOfflineMode) {
      return localDatasource.fetchTasks();
    } else {
      final result = await Future.wait([
        localDatasource.fetchTasks(),
        remoteDatasource.fetchTasks(),
      ]);

      final List<TaskEntity> localTasks =
          result[0].isRight() ? result[0].getOrElse(() => []) : [];

      final List<TaskEntity> remoteTasks =
          result[1].isRight() ? result[1].getOrElse(() => []) : [];

      await syncRemoteToLocal(localTasks: localTasks, remoteTasks: remoteTasks);

      return Right(remoteTasks);
    }
  }

  Future<void> syncRemoteToLocal({
    required List<TaskEntity> localTasks,
    required List<TaskEntity> remoteTasks,
  }) async {
    //Syncing tasks from remote to local
    for (final remoteTask in remoteTasks) {
      bool presentInLocal = false;

      for (final localTask in localTasks) {
        if (remoteTask.id == localTask.id) {
          presentInLocal = true;
          break;
        }
      }

      if (!presentInLocal) {
        await localDatasource.createTask(remoteTask);
      }
    }

    //Deleting tasks from local that are not present in remote
    for (final localTask in localTasks) {
      bool presentInRemote = false;
      for (final remoteTask in remoteTasks) {
        if (localTask.id == remoteTask.id) {
          presentInRemote = true;
          break;
        }
      }

      if (!presentInRemote) {
        await remoteDatasource.deleteTask(TaskModel.fromEntity(localTask));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> createTask(TaskEntity task) async {
    if (await isOfflineMode) {
      return localDatasource.createTask(task);
    }

    return remoteDatasource.createTask(TaskModel.fromEntity(task));
  }

  @override
  Future<Either<Failure, bool>> deleteTask(TaskEntity task) async {
    if (await isOfflineMode) {
      return localDatasource.deleteTask(task);
    }

    return remoteDatasource.deleteTask(TaskModel.fromEntity(task));
  }

  @override
  Future<Either<Failure, bool>> updateTask(TaskEntity task) async {
    if (await isOfflineMode) {
      return localDatasource.updateTask(task);
    }

    return remoteDatasource.updateTask(TaskModel.fromEntity(task));
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> syncTasks() async {
    final result = await Future.wait([
      localDatasource.fetchTasks(),
      remoteDatasource.fetchTasks(),
    ]);

    final List<TaskEntity> localTasks =
        result[0].isRight() ? result[0].getOrElse(() => []) : [];

    final List<TaskEntity> remoteTasks =
        result[1].isRight() ? result[1].getOrElse(() => []) : [];

    //Syncing tasks from local to remote
    for (final localTask in localTasks) {
      bool presentInRemote = false;

      for (final remoteTask in remoteTasks) {
        if (localTask.id == remoteTask.id) {
          presentInRemote = true;
          break;
        }
      }

      if (!presentInRemote) {
        await remoteDatasource.createTask(TaskModel.fromEntity(localTask));
      }
    }

    //Deleting tasks from remote that are not present in local
    for (final remoteTask in remoteTasks) {
      bool presentInLocal = false;
      for (final localTask in localTasks) {
        if (remoteTask.id == localTask.id) {
          presentInLocal = true;
          break;
        }
      }

      if (!presentInLocal) {
        await localDatasource.deleteTask(remoteTask);
      }
    }

    return Right(localTasks);
  }
}
