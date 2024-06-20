import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/shared/app_colors.dart';
import 'package:todo_list/core/widgets/myLogoTodoApp.dart';
import 'package:todo_list/core/widgets/separator.dart';
import 'package:todo_list/feature/home/ui/bloc/task_bloc.dart';
import 'package:todo_list/feature/home/ui/widgets/status_text.dart';
import 'package:todo_list/feature/home/ui/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // final ManageTasks _manageTasks = ManageTasks(TaskRepositoryImpl());
  final TextEditingController newTaskInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gray_700,
        toolbarHeight: 170,
        title: myLogoTodoApp(),
      ),
      body: BlocProvider(
        create: (context) => TaskBloc()..add(LoadTasksEvent()),
        child: Container(
          height: screenHeight,
          decoration: const BoxDecoration(
            color: AppColors.gray_600,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              children: [
                addNewTask(context),
                infoTasks(context),
                separator(),
                Expanded(child:
                    BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
                  if (state is TaskUpdatedState) {
                    return TaskList(
                      tasks: state.tasks,
                      onDelete: (index) {
                        context.read<TaskBloc>().add(RemoveTaskEvent(index));
                      },
                      onCheckboxChanged: (index, value) {
                        context
                            .read<TaskBloc>()
                            .add(UpdateTaskStatusEvent(index, value!));
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addNewTask(BuildContext context) {
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
                _addNewTask(context, text);
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _addNewTask(context, newTaskInput.text);
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

  void _addNewTask(BuildContext context, String newTask) {
    if (newTask.isNotEmpty) {
      context.read<TaskBloc>().add(AddTaskEvent(newTask));
      newTaskInput.clear();
    }
  }

  Widget infoTasks(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskUpdatedState) {
          final createdTasksCount = state.tasks.length;
          final completedTasksCount =
              state.tasks.where((task) => task.isCompleted).length;

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
        return Container();
      },
    );
  }
}
