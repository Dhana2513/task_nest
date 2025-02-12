import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import 'package:task_nest/core/platform/failure.dart';

import 'package:task_nest/domain/entity/task_entity.dart';

abstract class TaskLocalDatasourceProtocol {
  Future<Either<Failure, List<TaskEntity>>> fetchTasks();

  Future<Either<Failure, bool>> createTask(TaskEntity task);

  Future<Either<Failure, bool>> updateTask(TaskEntity task);

  Future<Either<Failure, bool>> deleteTask(TaskEntity task);
}

abstract class _TaskBoxKey {
  static const tasks = 'tasks';
}

class TaskLocalDatasource implements TaskLocalDatasourceProtocol {
  Box? _taskBox;

  TaskLocalDatasource() {
    initialize();
  }

  Future<void> initialize() async {
    _taskBox ??= await Hive.openBox(_TaskBoxKey.tasks);
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks() async {
    if (_taskBox == null) {
      await initialize();
    }

    final result =
        _taskBox?.values.toList().map((task) => task as TaskEntity).toList();
    return Right(result ?? []);
  }

  @override
  Future<Either<Failure, bool>> createTask(TaskEntity task) async {
    await _taskBox?.add(task);
    return Right(true);
  }

  @override
  Future<Either<Failure, bool>> deleteTask(TaskEntity task) async {
    await task.delete();
    return Right(true);
  }

  @override
  Future<Either<Failure, bool>> updateTask(TaskEntity task) async {
    await task.save();
    return Right(true);
  }
}
