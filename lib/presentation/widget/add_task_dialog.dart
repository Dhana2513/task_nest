import 'package:flutter/material.dart';
import 'package:task_nest/core/constant/constants.dart';
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

  void addTask() async {
    final title = titleController.text.trim();
    final subtitle = subtitleController.text.trim();

    if (title.isEmpty) {
      showError(Constants.provideTitle);
      return;
    }

    if (subtitle.isEmpty) {
      showError(Constants.provideSubtitle);
      return;
    }

    final task = TaskEntity(
      title: title,
      subtitle: subtitle,
      createdAt: DateTime.now(),
    );

    taskCubit.createTask(task);

    loadingNotifier.value = true;

    loadingNotifier.value = false;
    closeDialog();
  }

  void closeDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(BoxPadding.large),
              topRight: Radius.circular(BoxPadding.large),
            ),
            color: Theme.of(context).primaryColor.withOpacity(0.9),
          ),
          padding: const EdgeInsets.only(
            left: BoxPadding.medium,
            right: BoxPadding.small,
            top: BoxPadding.small,
            bottom: BoxPadding.small,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Constants.addTask,
                style: UITextStyle.title.copyWith(color: Colors.white),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.all(BoxPadding.small),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        Padding(
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

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(BoxPadding.medium),
                      ),
                    ),
                    onPressed: addTask,
                    child: Padding(
                      padding: const EdgeInsets.all(BoxPadding.small),
                      child: Text(
                        Constants.submit,
                        style:
                            UITextStyle.subtitle1.copyWith(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
