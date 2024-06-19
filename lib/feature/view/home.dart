import 'package:flutter/material.dart';
import 'package:todo_list/core/shared/app_colors.dart';
import 'package:todo_list/core/widgets/myLogoTodoApp.dart';
import 'package:todo_list/core/widgets/separator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int createdtasksCount = 0;
  int completedtasksCount = 0;
  List<String> tasks = [];
  List<bool> tasksCompletionStatus = [];

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
                  tasks: tasks,
                  tasksCompletionStatus: tasksCompletionStatus,
                  onDelete: (index) {
                    setState(() {
                      tasks.removeAt(index);
                      tasksCompletionStatus.removeAt(index);
                      createdtasksCount--;
                      completedtasksCount = tasksCompletionStatus
                          .where((status) => status)
                          .length;
                    });
                  },
                  onCheckboxChanged: (index, value) {
                    setState(() {
                      tasksCompletionStatus[index] = value!;
                      completedtasksCount = tasksCompletionStatus
                          .where((status) => status)
                          .length;
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
        tasks.add(newTask);
        tasksCompletionStatus.add(false);
        createdtasksCount++;
        newTaskInput.clear();
      });
    }
  }

  Widget infoTasks() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        margin: const EdgeInsets.only(top: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatusText(
              label: 'Criadas ',
              count: createdtasksCount,
              labelColor: AppColors.blue,
              backgroundColor: AppColors.gray_400,
              countColor: AppColors.gray_200,
            ),
            StatusText(
              label: 'Concluídas ',
              count: completedtasksCount,
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

class StatusText extends StatelessWidget {
  final String label;
  final int count;
  final Color labelColor;
  final Color backgroundColor;
  final Color countColor;

  StatusText({
    super.key,
    required this.label,
    required this.count,
    required this.labelColor,
    required this.backgroundColor,
    required this.countColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: labelColor,
        ),
        text: '$label ',
        children: [
          WidgetSpan(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: countColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<String> tasks;
  final List<bool> tasksCompletionStatus;
  final Function(int) onDelete;
  final Function(int, bool?) onCheckboxChanged;

  TaskList({
    required this.tasks,
    required this.tasksCompletionStatus,
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
            Text(
              'Você ainda não tem tarefas cadastradas',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.gray_300,
              ),
            ),
            const SizedBox(height: 10),
            Text(
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
            taskTitle: tasks[index],
            isCompleted: tasksCompletionStatus[index],
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

class TaskCard extends StatelessWidget {
  final String taskTitle;
  final bool isCompleted;
  final Function(bool?)? onCheckboxChanged;
  final Function()? onDelete;

  TaskCard({
    required this.taskTitle,
    this.isCompleted = false,
    this.onCheckboxChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
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
            icon: Icon(Icons.delete_forever_outlined),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
