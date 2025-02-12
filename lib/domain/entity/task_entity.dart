import 'package:hive/hive.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  @HiveField(0)
  String? documentID;

  @HiveField(1)
  String id;

  @HiveField(2)
  String title;

  @HiveField(3)
  String subtitle;

  @HiveField(4)
  bool completed;

  TaskEntity({
    this.documentID,
    required this.id,
    required this.title,
    required this.subtitle,
    this.completed = false,
  });

  void copyWith({
    String? documentID,
    String? id,
    String? title,
    String? subtitle,
    bool? completed,
    DateTime? createdAt,
  }) {
    this.documentID = documentID ?? this.documentID;
    this.id = id ?? this.id;
    this.title = title ?? this.title;
    this.subtitle = subtitle ?? this.subtitle;
    this.completed = completed ?? this.completed;
  }
}
