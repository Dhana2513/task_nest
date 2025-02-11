import 'package:flutter/material.dart';
import 'package:task_nest/dependency_manager.dart';
import 'package:task_nest/presentation/bloc/task_cubit.dart';

import 'widget/add_task_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final taskCubit = DependencyManager.registrar<TaskCubit>();

  @override
  void initState() {
    super.initState();
    taskCubit.fetchTasks();
  }

  void presentAddTaskDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(child: AddTaskDialog()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: presentAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
