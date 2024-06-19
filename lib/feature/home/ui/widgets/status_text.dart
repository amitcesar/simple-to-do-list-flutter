import 'package:flutter/material.dart';

class StatusText extends StatelessWidget {
  final String label;
  final int count;
  final Color labelColor;
  final Color backgroundColor;
  final Color countColor;

  StatusText({
    super.key,
    required this.label,
    required this.count,
    required this.labelColor,
    required this.backgroundColor,
    required this.countColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: labelColor,
        ),
        text: '$label ',
        children: [
          WidgetSpan(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: countColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
