import 'package:task_nest/domain/usecase/create_task.dart';
import 'package:task_nest/domain/usecase/update_task.dart';

import 'delete_task.dart';
import 'fetch_tasks.dart';

class UseCases {
  final FetchTasks fetchTasks;
  final CreateTask createTask;
  final DeleteTask deleteTask;
  final UpdateTask updateTask;

  UseCases({
    required this.fetchTasks,
    required this.createTask,
    required this.deleteTask,
    required this.updateTask,
  });
}
