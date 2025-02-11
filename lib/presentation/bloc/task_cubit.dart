import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_nest/core/platform/usecase/params.dart';
import 'package:task_nest/domain/entity/task_entity.dart';
import 'package:task_nest/domain/usecase/usecases.dart';

import '../../core/platform/failure.dart';
import '../../domain/usecase/params/params.dart';

class TaskCubit extends Cubit<List<TaskEntity>> {
  final UseCases useCases;

  TaskCubit({required this.useCases}) : super([]);

  Future<void> fetchTasks() async {
    final result = await useCases.fetchTasks(NoParam());
    result.fold(
      (failure) {},
      (tasks) {
        if (tasks?.isNotEmpty == true) {
          emit(tasks!);
        }
      },
    );
  }

  Future<void> createTask(TaskEntity task) async {
    final result = await useCases.createTask(TaskParams(task: task));
    refreshTaskOnSuccess(result);
  }

  Future<void> updateTask(TaskEntity task) async {
    final result = await useCases.updateTask(TaskParams(task: task));
    refreshTaskOnSuccess(result);
  }

  Future<void> deleteTask(TaskEntity task) async {
    final result = await useCases.deleteTask(TaskParams(task: task));
    refreshTaskOnSuccess(result);
  }

  void refreshTaskOnSuccess(Either<Failure, bool?> result) {
    result.fold((failure) {}, (completed) {
      fetchTasks();
    });
  }
}
