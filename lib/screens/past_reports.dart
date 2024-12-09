import 'package:flutter/material.dart';


class PastReports extends StatefulWidget {
  const PastReports({super.key});

  @override
  State<PastReports> createState() => _PastReportsState();
}

class _PastReportsState extends State<PastReports> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("No Past Reports..."),
      )
    );
  }
}