import 'package:flutter/material.dart';
import 'package:task_nest/core/constant/text_style.dart';
import 'package:task_nest/core/extension/box_padding.dart';
import 'package:task_nest/core/platform/local_database.dart';
import 'package:task_nest/dependency_manager.dart';
import 'package:task_nest/presentation/bloc/task_cubit.dart';

import '../core/constant/constants.dart';
import '../domain/entity/task_entity.dart';
import 'widget/add_task_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final taskCubit = DependencyManager.registrar<TaskCubit>();
  final ValueNotifier<bool> offlineModeNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    taskCubit.fetchTasks();
    initOfflineModeNotifier();
  }

  void initOfflineModeNotifier() async {
    offlineModeNotifier.value = await LocalDatabase.instance.isOffline;
  }

  void presentAddTaskDialog({TaskEntity? task}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(child: AddTaskDialog(task: task)),
    );
  }

  Future<void> syncTasks() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: BoxPadding.xxLarge,
          children: [
            CircularProgressIndicator(),
            Material(
              color: Colors.transparent,
              child: Text(
                Constants.syncingTasks,
                style: UITextStyle.body.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

    await taskCubit.syncTasks();

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        actions: [
          ValueListenableBuilder(
            valueListenable: offlineModeNotifier,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: BoxPadding.small,
                children: [
                  Text(
                    Constants.offline,
                    style: UITextStyle.body.copyWith(
                      color: Colors.grey.shade100,
                    ),
                  ),
                  Switch(
                    value: value,
                    onChanged: (value) async {
                      await LocalDatabase.instance.setOffline(value);
                      offlineModeNotifier.value = value;
                      if (value == false) {
                        syncTasks();
                      }
                    },
                  )
                ],
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: taskCubit.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!;
          if (tasks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: BoxPadding.xxxLarge,
                horizontal: BoxPadding.large,
              ),
              child: Column(
                spacing: BoxPadding.large,
                children: [
                  Text(
                    Constants.noTaskTitle,
                    style: UITextStyle.title,
                  ),
                  Text(
                    Constants.noTaskSubtitle,
                    textAlign: TextAlign.center,
                    style: UITextStyle.bodyLarge,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: tasks.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(thickness: 0.5);
            },
            itemBuilder: (context, index) {
              final task = tasks[index];

              return ListTile(
                leading: Checkbox(
                  value: task.completed,
                  onChanged: (value) {
                    task.completed = !task.completed;

                    taskCubit.updateTask(task);
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          presentAddTaskDialog(task: task);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                  ],
                ),
                title: Text(task.title),
                subtitle: Text(task.subtitle),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: presentAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
