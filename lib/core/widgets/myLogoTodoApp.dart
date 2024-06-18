import 'package:flutter/material.dart';

Widget myLogoTodoApp() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        'assets/icons/rocket.png',
      ),
      Image.asset(
        'assets/icons/to.png',
      ),
      Image.asset(
        'assets/icons/do.png',
      ),
    ],
  );
}
