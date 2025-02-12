import 'package:dartz/dartz.dart';
import 'package:task_nest/core/platform/usecase/params.dart';
import 'package:task_nest/core/platform/usecase/usecase.dart';

import '../entity/task_entity.dart';
import '../repository/task_repository_protocol.dart';

class SyncTasks extends UseCase<List<TaskEntity>, NoParam> {
  final TaskRepositoryProtocol repository;

  SyncTasks({required this.repository});

  @override
  Future<Either<Failure, List<TaskEntity>?>> call(NoParam params) {
    return repository.syncTasks();
  }
}
