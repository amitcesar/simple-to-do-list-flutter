import 'package:bloc/bloc.dart';

import 'package:todo_list/feature/home/domain/usecases/manage_tasks.dart';
import 'package:todo_list/feature/home/ui/bloc/task_states.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit(this.manageTasks) : super(TaskInitial());

  final ManageTasks manageTasks;

  void addTask(String taskTitle) {
    manageTasks.addTask(taskTitle);
    emit(TaskLoaded(manageTasks.getTasks()));
  }

  void removeTask(int taskIndex) {
    manageTasks.removeTask(taskIndex);
    emit(TaskLoaded(manageTasks.getTasks()));
  }

  void updateTaskStatus(int index, bool isCompleted) {
    manageTasks.updateTaskStatus(index, isCompleted);
    emit(TaskLoaded(manageTasks.getTasks()));
  }

  void loadTasks() {
    emit(TaskLoaded(manageTasks.getTasks()));
  }
}
