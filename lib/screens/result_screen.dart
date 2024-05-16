import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int result;
  const Result({super.key,required this.result});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Mild Anxiety'),
            Text('Suggestion what to do next'),
          ],
        ),
      ),
    );
  }
}