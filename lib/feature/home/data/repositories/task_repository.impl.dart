import 'package:todo_list/feature/home/domain/entities/task.dart';
import 'package:todo_list/feature/home/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  void addTask(Task task) {
    _tasks.add(task);
  }

  @override
  List<Task> getTasks() {
    return _tasks;
  }

  @override
  void removeTask(int index) {
    _tasks.removeAt(index);
  }

  @override
  void updateTaskStatus(int index, bool isCompleted) {
    _tasks[index].isCompleted = isCompleted;
  }
}
