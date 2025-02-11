import 'package:dartz/dartz.dart';
import 'package:task_nest/domain/entity/task_entity.dart';

import '../../core/platform/usecase/params.dart';
import '../../core/platform/usecase/usecase.dart';
import '../repository/task_repository_protocol.dart';

class FetchTasks extends UseCase<List<TaskEntity>, NoParam> {
  final TaskRepositoryProtocol repository;

  FetchTasks({required this.repository});

  @override
  Future<Either<Failure, List<TaskEntity>?>> call(NoParam params) {
    return repository.fetchTasks();
  }
}
