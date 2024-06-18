import 'package:flutter/material.dart';
import 'package:todo_list/core/shared/app_colors.dart';

Widget InputTask() {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.gray_400, borderRadius: BorderRadius.circular(4)),
    child: TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          border: InputBorder.none,
          hintText: 'Adicione uma nova tarefa'),
    ),
  );
}
