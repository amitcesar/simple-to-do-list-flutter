import 'package:flutter/material.dart';
import 'package:todo_list/core/shared/app_colors.dart';
import 'package:todo_list/core/widgets/myLogoTodoApp.dart';
import 'package:todo_list/core/widgets/separator.dart';
import 'package:todo_list/feature/home/data/repositories/task_repository.impl.dart';
import 'package:todo_list/feature/home/domain/usecases/manage_tasks.dart';
import 'package:todo_list/feature/home/ui/widgets/status_text.dart';
import 'package:todo_list/feature/home/ui/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ManageTasks _manageTasks = ManageTasks(TaskRepositoryImpl());
  TextEditingController newTaskInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gray_700,
        toolbarHeight: 170,
        title: myLogoTodoApp(),
      ),
      body: Container(
        height: screenHeight,
        decoration: const BoxDecoration(
          color: AppColors.gray_600,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: [
              addNewTask(),
              infoTasks(),
              separator(),
              Expanded(
                child: TaskList(
                  tasks: _manageTasks.getTasks(),
                  onDelete: (index) {
                    setState(() {
                      _manageTasks.removeTask(index);
                    });
                  },
                  onCheckboxChanged: (index, value) {
                    setState(() {
                      _manageTasks.updateTaskStatus(index, value!);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addNewTask() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: AppColors.gray_400,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: newTaskInput,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: 'Adicione uma nova tarefa',
                hintStyle:
                    const TextStyle(fontSize: 16.0, color: AppColors.gray_300),
              ),
              onSubmitted: (text) {
                _addNewTask(text);
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _addNewTask(newTaskInput.text);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            backgroundColor: AppColors.blueDark,
            minimumSize: const Size(50, 50),
          ),
          child: const Text(
            '+',
            style: TextStyle(fontSize: 18, color: AppColors.white),
          ),
        ),
      ],
    );
  }

  void _addNewTask(String newTask) {
    if (newTask.isNotEmpty) {
      setState(() {
        _manageTasks.addTask(newTask);
        newTaskInput.clear();
      });
    }
  }

  Widget infoTasks() {
    final tasks = _manageTasks.getTasks();
    final createdTasksCount = tasks.length;
    final completedTasksCount = tasks.where((task) => task.isCompleted).length;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        margin: const EdgeInsets.only(top: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatusText(
              label: 'Criadas ',
              count: createdTasksCount,
              labelColor: AppColors.blue,
              backgroundColor: AppColors.gray_400,
              countColor: AppColors.gray_200,
            ),
            StatusText(
              label: 'Concluídas ',
              count: completedTasksCount,
              labelColor: AppColors.purple,
              backgroundColor: AppColors.gray_400,
              countColor: AppColors.gray_200,
            ),
          ],
        ),
      ),
    );
  }
}
