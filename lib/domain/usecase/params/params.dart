import '../../../core/platform/usecase/params.dart';
import '../../entity/task_entity.dart';

class TaskParams extends Params {
  final TaskEntity task;

  TaskParams({required this.task});
}
