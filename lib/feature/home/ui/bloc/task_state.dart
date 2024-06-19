part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskUpdatedState extends TaskState {
  final List<Task> tasks;
  const TaskUpdatedState(this.tasks);

  @override
  List<Object> get props => [tasks];
}
