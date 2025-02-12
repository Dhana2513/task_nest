import 'package:flutter/material.dart';
import 'package:task_nest/core/constant/constants.dart';
import 'package:task_nest/core/widget/ui_button.dart';
import 'package:task_nest/core/widget/ui_dialog.dart';
import 'package:task_nest/domain/entity/task_entity.dart';

import '../../core/constant/text_style.dart';
import '../../core/extension/box_padding.dart';
import '../../core/widget/ui_text_field.dart';
import '../../dependency_manager.dart';
import '../bloc/task_cubit.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({
    super.key,
    this.task,
  });

  final TaskEntity? task;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late final TextEditingController titleController;
  late final TextEditingController subtitleController;

  final loadingNotifier = ValueNotifier<bool>(false);
  final taskCubit = DependencyManager.registrar<TaskCubit>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task?.title ?? '');
    subtitleController =
        TextEditingController(text: widget.task?.subtitle ?? '');
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: UITextStyle.body,
    )));
  }

  Future<void> saveTask() async {
    final title = titleController.text.trim();
    final subtitle = subtitleController.text.trim();

    if (title.isEmpty) {
      showError(Constants.provideTitle);
      return;
    }

    loadingNotifier.value = true;

    if (widget.task != null) {
      widget.task!.copyWith(
        title: title,
        subtitle: subtitle,
      );

      taskCubit.updateTask(widget.task!);
    } else {
      final task = TaskEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        subtitle: subtitle,
      );

      taskCubit.createTask(task);
    }

    loadingNotifier.value = false;
    closeDialog();
  }

  void closeDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return UiDialog(
      title: Constants.addTask,
      body: Padding(
        padding: const EdgeInsets.all(BoxPadding.large),
        child: Column(
          spacing: BoxPadding.xStandard,
          children: [
            UiTextField(
              controller: titleController,
              hintText: Constants.title,
              keyboardType: TextInputType.name,
            ),
            UiTextField(
              controller: subtitleController,
              hintText: Constants.subtitle,
              keyboardType: TextInputType.name,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: loadingNotifier,
              builder: (BuildContext context, loading, Widget? child) {
                if (loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return UIButton(
                  padding: EdgeInsets.all(BoxPadding.small),
                  title: Constants.submit,
                  onPressed: saveTask,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
