import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import 'package:task_nest/core/platform/failure.dart';

import 'package:task_nest/domain/entity/task_entity.dart';

abstract class TaskLocalDatasourceProtocol {
  Future<Either<Failure, List<TaskEntity>>> fetchTasks();

  Future<Either<Failure, bool>> createTask(TaskEntity taskModel);

  Future<Either<Failure, bool>> updateTask(TaskEntity taskModel);

  Future<Either<Failure, bool>> deleteTask(TaskEntity taskModel);
}

class TaskLocalDatasource implements TaskLocalDatasourceProtocol {
    Box? _taskBox;

  TaskLocalDatasource() {
    initialize();
  }

  Future<void> initialize() async {
    _taskBox = await Hive.openBox('tasks');
  }

  @override
  Future<Either<Failure, bool>> createTask(TaskEntity taskModel) async {
    final result = await _taskBox?.add(taskModel);

    if (result != 0) {
      return Right(true);
    } else {
      return Left(Failure(
        message: 'Failed to create task',
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask(TaskEntity taskModel) async {
    return Right(true);
    // final result = await _taskBox.delete(taskModel);
    //
    // if (result != 0) {
    //   return Right(true);
    // } else {
    //   return Left(Failure(
    //     message: 'Failed to create task',
    //   ));
    // }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks() async {
    final result = _taskBox?.values.toList().map((task) => task as TaskEntity).toList();
    return Right(result ?? []);
  }

  @override
  Future<Either<Failure, bool>> updateTask(TaskEntity taskModel) async {
    return Right(true);

    // final result = await _taskBox.(taskModel);
    //
    // if (result != 0) {
    //   return Right(true);
    // } else {
    //   return Left(Failure(
    //     message: 'Failed to create task',
    //   ));
    // }
  }
}
