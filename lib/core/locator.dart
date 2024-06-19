import 'package:get_it/get_it.dart';
import 'package:todo_list/feature/home/data/repositories/task_repository.impl.dart';
import 'package:todo_list/feature/home/domain/usecases/manage_tasks.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<TaskRepositoryImpl>(() => TaskRepositoryImpl());
  locator.registerLazySingleton<ManageTasks>(
    () => ManageTasks(locator<TaskRepositoryImpl>()),
  );
}
