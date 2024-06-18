import 'package:flutter/material.dart';
import 'package:todo_list/core/shared/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int createdtasksCount = 0;
  final int completedtasksCount = 0;
  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.gray_700,
          toolbarHeight: 170,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/rocket.png',
              ),
              Image.asset(
                'assets/icons/to.png',
              ),
              Image.asset(
                'assets/icons/do.png',
              ),
            ],
          ),
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
                taskSeparator(),
                Expanded(
                  child: TaskList(tasks: tasks),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget addNewTask() {
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(
            right: 5,
          ),
          decoration: BoxDecoration(
            color: AppColors.gray_400,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    )),
                hintText: 'Adicione uma nova tarefa',
                hintStyle:
                    const TextStyle(fontSize: 16.0, color: AppColors.gray_300)),
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          backgroundColor: AppColors.blueDark,
          minimumSize: const Size(50, 50),
        ),
        child: const Text(
          '+',
          style: TextStyle(fontSize: 18, color: AppColors.white),
        ),
      )
    ],
  );
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
            count: 0,
            labelColor: AppColors.blue,
            backgroundColor: AppColors.gray_400,
            countColor: AppColors.gray_200,
          ),
          StatusText(
            label: 'Concluídas ',
            count: 0,
            labelColor: AppColors.purple,
            backgroundColor: AppColors.gray_400,
            countColor: AppColors.gray_200,
          ),
        ],
      ),
    ),
  );
}

Widget taskSeparator() {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.gray_300, width: 1.0))),
  );
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

  TaskList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          'Você ainda não tem tarefas cadastradas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index]),
          );
        },
      );
    }
  }
}
