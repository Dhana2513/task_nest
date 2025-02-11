import 'package:dartz/dartz.dart';
import 'package:task_nest/core/platform/usecase/usecase.dart';
import 'package:task_nest/domain/usecase/params/params.dart';

import '../repository/task_repository_protocol.dart';


class DeleteTask extends UseCase<bool, TaskParams> {
  final TaskRepositoryProtocol repository;

  DeleteTask({required this.repository});

  @override
  Future<Either<Failure, bool?>> call(TaskParams params) {
    return repository.deleteTask(params.task);
  }
}
