import 'package:equatable/equatable.dart';
import 'package:todo_list/feature/home/domain/entities/task.dart';

abstract class TaskStates extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskStates {}

class TaskLoaded extends TaskStates {
  final List<Task> tasks;
  TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}
