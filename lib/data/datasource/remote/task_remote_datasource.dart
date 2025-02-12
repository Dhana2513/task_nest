import 'package:dartz/dartz.dart';

import 'package:task_nest/core/platform/failure.dart';
import 'package:task_nest/data/model/task_model.dart';

import 'package:task_nest/domain/entity/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TaskRemoteDatasourceProtocol {
  Future<Either<Failure, List<TaskEntity>>> fetchTasks();

  Future<Either<Failure, bool>> createTask(TaskModel task);

  Future<Either<Failure, bool>> updateTask(TaskModel task);

  Future<Either<Failure, bool>> deleteTask(TaskModel task);
}

abstract class _FirestoreKey {
  static const tasks = 'tasks';
}

class TaskRemoteDatasource implements TaskRemoteDatasourceProtocol {
  TaskRemoteDatasource() {
    _firestore = FirebaseFirestore.instance;
    _tasks = _firestore.collection(_FirestoreKey.tasks);
  }

  late final FirebaseFirestore _firestore;
  late final CollectionReference _tasks;

  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks() async {
    final result = await _tasks.get();

    final tasks = result.docs
        .map(
          (doc) => TaskModel.fromJson(
            documentID: doc.id,
            json: doc.data() as Map<String, dynamic>,
          ),
        )
        .toList();

    tasks.sort(
        (taskA, taskB) => int.parse(taskA.id) > int.parse(taskB.id) ? 1 : 0);

    return Right(tasks);
  }

  @override
  Future<Either<Failure, bool>> createTask(TaskModel task) async {
    await _tasks.add(task.toJson());
    return Right(true);
  }

  @override
  Future<Either<Failure, bool>> deleteTask(TaskModel task) async {
    _tasks.doc(task.documentID).delete();
    return Right(true);
  }

  @override
  Future<Either<Failure, bool>> updateTask(TaskModel task) async {
    final doc = _tasks.doc(task.documentID);
    doc.update(task.toJson());
    return Right(true);
  }
}
