import 'package:task_nest/core/extension/map_extension.dart';

import '../../domain/entity/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.title,
    required super.subtitle,
    super.isCompleted = false,
    required super.createdAt,
  });

  factory TaskModel.fromModel(Map<String, dynamic> json) {
    return TaskModel(
      title: json.getSting(TaskModelKey.title) ?? '',
      subtitle: json.getSting(TaskModelKey.subtitle) ?? '',
      isCompleted: json.getBool(TaskModelKey.isCompleted) ?? false,
      createdAt: json.getDateTime(TaskModelKey.createdAt) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TaskModelKey.title: title,
      TaskModelKey.subtitle: subtitle,
      TaskModelKey.isCompleted: isCompleted,
      TaskModelKey.createdAt: createdAt,
    };
  }
}

class TaskModelKey {
  static const title = 'title';
  static const subtitle = 'subtitle';
  static const isCompleted = 'isCompleted';
  static const createdAt = 'createdAt';
}
