import 'package:task_nest/core/extension/map_extension.dart';

import '../../domain/entity/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    super.documentID,
    required super.id,
    required super.title,
    required super.subtitle,
    super.completed = false,
  });

  factory TaskModel.fromEntity(TaskEntity task) {
    return TaskModel(
      documentID: task.documentID,
      id: task.id,
      title: task.title,
      subtitle: task.subtitle,
      completed: task.completed,
    );
  }

  factory TaskModel.fromJson({
    required String documentID,
    required Map<String, dynamic> json,
  }) {
    return TaskModel(
      documentID: documentID,
      id: json.getSting(TaskModelKey.id) ?? '',
      title: json.getSting(TaskModelKey.title) ?? '',
      subtitle: json.getSting(TaskModelKey.subtitle) ?? '',
      completed: json.getBool(TaskModelKey.completed) ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TaskModelKey.id: id,
      TaskModelKey.title: title,
      TaskModelKey.subtitle: subtitle,
      TaskModelKey.completed: completed,
    };
  }
}

class TaskModelKey {
  static const id = 'id';
  static const title = 'title';
  static const subtitle = 'subtitle';
  static const completed = 'completed';
}
