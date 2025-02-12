import 'package:flutter/material.dart';
import 'package:task_nest/core/constant/text_style.dart';
import 'package:task_nest/core/extension/box_padding.dart';
import 'package:task_nest/core/platform/local_database.dart';
import 'package:task_nest/core/widget/ui_button.dart';
import 'package:task_nest/core/widget/ui_dialog.dart';
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
    initialize();
  }

  Future<void> initialize() async {
    taskCubit.fetchTasks();
    offlineModeNotifier.value = await LocalDatabase.instance.isOffline;
  }

  void presentDeleteTaskDialog({required TaskEntity task}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: UiDialog(
            title: Constants.deleteTaskTitle,
            body: Padding(
              padding: const EdgeInsets.all(BoxPadding.large),
              child: Column(
                spacing: BoxPadding.large,
                children: [
                  Text(
                    Constants.deleteTaskMessage,
                    style: UITextStyle.title.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: BoxPadding.large,
                    children: [
                      UIButton(
                        title: Constants.delete,
                        onPressed: () async {
                          dismissDialog();

                          await taskCubit.deleteTask(task);
                        },
                      ),
                      UIButton(
                        title: Constants.cancel,
                        onPressed: dismissDialog,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void dismissDialog() {
    Navigator.of(context).pop();
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

    dismissDialog();
  }

  Widget iconButton({required IconData icon, required VoidCallback onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  PreferredSizeWidget get appBar => AppBar(
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
                      } else {
                        taskCubit.fetchTasks();
                      }
                    },
                  )
                ],
              );
            },
          ),
        ],
      );

  Widget get noTasksView => Padding(
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

  Widget taskItemView(TaskEntity task) {
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
          iconButton(
            icon: Icons.edit,
            onTap: () => presentAddTaskDialog(task: task),
          ),
          iconButton(
            icon: Icons.delete,
            onTap: () => presentDeleteTaskDialog(task: task),
          ),
        ],
      ),
      title: Text(task.title),
      subtitle: Text(task.subtitle),
    );
  }

  Widget taskListView(List<TaskEntity> tasks) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      separatorBuilder: (context, index) => Divider(
        thickness: 0.5,
        height: BoxPadding.xxxSmall,
      ),
      itemBuilder: (context, index) {
        return taskItemView(tasks[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: StreamBuilder(
        stream: taskCubit.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!;

          if (tasks.isEmpty) {
            return noTasksView;
          }

          final incompleteTasks =
              tasks.where((task) => !task.completed).toList();
          final completedTasks = tasks.where((task) => task.completed).toList();

          return ListView(
            children: [
              if (incompleteTasks.isNotEmpty) ...[
                taskListView(incompleteTasks),
              ],
              if (completedTasks.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(
                    top: BoxPadding.large,
                    left: BoxPadding.large,
                    bottom: BoxPadding.small,
                  ),
                  child: Text(
                    Constants.completedTasks,
                    style: UITextStyle.subtitle1,
                  ),
                ),
                taskListView(completedTasks),
              ],
            ],
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
