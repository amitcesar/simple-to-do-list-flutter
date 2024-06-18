import 'package:flutter/material.dart';
import 'package:todo_list/core/shared/app_colors.dart';

Widget separator() {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.gray_300, width: 1.0))),
  );
}
