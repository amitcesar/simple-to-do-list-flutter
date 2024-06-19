import 'package:todo_list/feature/home/domain/entities/task.dart';
import 'package:todo_list/feature/home/domain/repositories/task_repository.dart';

class ManageTasks {
  final TaskRepository repository;
  ManageTasks(this.repository);

  void addTask(String title) {
    repository.addTask(Task(title: title));
  }

  void removeTask(int index) {
    repository.removeTask(index);
  }

  List<Task> getTasks() {
    return repository.getTasks();
  }

  void updateTaskStatus(int index, bool isCompleted) {
    repository.updateTaskStatus(index, isCompleted);
  }
}
