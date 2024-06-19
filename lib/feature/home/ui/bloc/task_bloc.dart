import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/locator.dart';
import 'package:todo_list/feature/home/domain/entities/task.dart';
import 'package:todo_list/feature/home/domain/usecases/manage_tasks.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ManageTasks manageTasks = locator<ManageTasks>();

  TaskBloc() : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) {
      manageTasks.addTask(event.title);
      emit(TaskUpdatedState(manageTasks.getTasks()));
    });

    on<RemoveTaskEvent>((event, emit) {
      manageTasks.removeTask(event.index);
      emit(TaskUpdatedState(manageTasks.getTasks()));
    });

    on<UpdateTaskStatusEvent>((event, emit) {
      manageTasks.updateTaskStatus(event.index, event.isCompleted);
      emit(TaskUpdatedState(manageTasks.getTasks()));
    });

    on<LoadTasksEvent>((event, emit) {
      emit(TaskUpdatedState(manageTasks.getTasks()));
    });
  }
}
