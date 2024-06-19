import 'package:todo_list/feature/home/domain/entities/task.dart';

abstract class TaskRepository {
  void addTask(Task task);
  void removeTask(int index);
  List<Task> getTasks();
  void updateTaskStatus(int index, bool isCompleted);
}
