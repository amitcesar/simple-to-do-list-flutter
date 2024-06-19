import 'package:flutter/material.dart';
import 'package:todo_list/core/shared/app_colors.dart';
import 'package:todo_list/feature/home/domain/entities/task.dart';
import 'package:todo_list/feature/home/ui/widgets/task_card.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(int) onDelete;
  final Function(int, bool?) onCheckboxChanged;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onDelete,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/Clipboard.png', // Coloque o caminho da sua imagem aqui
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Você ainda não tem tarefas cadastradas',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.gray_300,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Crie tarefas e organize seus itens a fazer',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.gray_300,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskCard(
            taskTitle: tasks[index].title,
            isCompleted: tasks[index].isCompleted,
            onCheckboxChanged: (bool? value) {
              onCheckboxChanged(index, value);
            },
            onDelete: () {
              onDelete(index);
            },
          );
        },
      );
    }
  }
}
