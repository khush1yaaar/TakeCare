import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  Option({super.key, required this.option, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? theme.textTheme.bodyLarge!.color : theme.appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              option,
              style: TextStyle(
                color: isSelected
                    ? theme.appBarTheme.backgroundColor
                    : theme.textTheme.bodyLarge!.color,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
