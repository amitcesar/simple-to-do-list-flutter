part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final String title;

  const AddTaskEvent(this.title);

  @override
  List<Object> get props => [title];
}

class RemoveTaskEvent extends TaskEvent {
  final int index;
  const RemoveTaskEvent(this.index);

  @override
  List<Object> get props => [index];
}

class UpdateTaskStatusEvent extends TaskEvent {
  final int index;
  final bool isCompleted;

  const UpdateTaskStatusEvent(this.index, this.isCompleted);
}

class LoadTasksEvent extends TaskEvent {}
