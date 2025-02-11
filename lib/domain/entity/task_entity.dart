import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  const TaskEntity({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        isCompleted,
        createdAt,
      ];
}
