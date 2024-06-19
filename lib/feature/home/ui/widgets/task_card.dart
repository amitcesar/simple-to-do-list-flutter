import 'package:flutter/material.dart';
import 'package:todo_list/core/shared/app_colors.dart';

class TaskCard extends StatelessWidget {
  final String taskTitle;
  final bool isCompleted;
  final Function(bool?)? onCheckboxChanged;
  final Function()? onDelete;

  const TaskCard({
    super.key,
    required this.taskTitle,
    this.isCompleted = false,
    this.onCheckboxChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.gray_400,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: onCheckboxChanged,
          ),
          Expanded(
            child: Text(
              taskTitle,
              style: TextStyle(
                color: AppColors.gray_100,
                fontSize: 14.0,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
