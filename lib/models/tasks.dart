import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class Tasks extends ChangeNotifier {
  List<Task> tasks;

  Tasks({required this.tasks});
}
