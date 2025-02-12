import 'package:get_it/get_it.dart';
import 'package:task_nest/data/datasource/local/task_local_datasource.dart';
import 'package:task_nest/data/datasource/remote/task_remote_datasource.dart';
import 'package:task_nest/data/repository/task_repository.dart';
import 'package:task_nest/domain/usecase/create_task.dart';
import 'package:task_nest/domain/usecase/delete_task.dart';
import 'package:task_nest/domain/usecase/sync_tasks.dart';
import 'package:task_nest/domain/usecase/update_task.dart';

import 'domain/repository/task_repository_protocol.dart';
import 'domain/usecase/fetch_tasks.dart';
import 'domain/usecase/usecases.dart';
import 'presentation/bloc/task_cubit.dart';

class DependencyManager {
  DependencyManager._();

  static final registrar = GetIt.instance;

  static void initialize() {
    registrar.registerFactory<TaskLocalDatasourceProtocol>(
      () => TaskLocalDatasource(),
    );

    registrar.registerLazySingleton<TaskRemoteDatasourceProtocol>(
      () => TaskRemoteDatasource(),
    );

    registrar.registerLazySingleton<TaskRepositoryProtocol>(
      () => TaskRepository(
        localDatasource: registrar(),
        remoteDatasource: registrar(),
      ),
    );

    registrar.registerLazySingleton<FetchTasks>(
      () => FetchTasks(repository: registrar()),
    );
    registrar.registerLazySingleton<CreateTask>(
      () => CreateTask(repository: registrar()),
    );
    registrar.registerLazySingleton<UpdateTask>(
      () => UpdateTask(repository: registrar()),
    );
    registrar.registerLazySingleton<DeleteTask>(
      () => DeleteTask(repository: registrar()),
    );
    registrar.registerLazySingleton<SyncTasks>(
      () => SyncTasks(repository: registrar()),
    );

    registrar.registerLazySingleton<UseCases>(
      () => UseCases(
        fetchTasks: registrar(),
        createTask: registrar(),
        deleteTask: registrar(),
        updateTask: registrar(),
        syncTasks: registrar(),
      ),
    );

    registrar.registerLazySingleton<TaskCubit>(
      () => TaskCubit(useCases: registrar()),
    );
  }
}
