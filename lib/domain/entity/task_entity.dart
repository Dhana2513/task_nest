import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends Equatable {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String subtitle;

  @HiveField(2)
  final bool isCompleted;

  @HiveField(3)
  final DateTime createdAt;

  const TaskEntity({
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        title,
        subtitle,
        isCompleted,
        createdAt,
      ];
}
