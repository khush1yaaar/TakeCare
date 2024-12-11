import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int result;
  final String keyword;
  const Result({super.key, required this.result, required this.keyword});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: theme.iconTheme.color),
        ),
        title: Text(
          'See Your Results',
          style: TextStyle(
            color: theme.appBarTheme.backgroundColor ?? Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildTitleCard(theme),
              const SizedBox(height: 20),
              _buildScoreCard(theme),
              const SizedBox(height: 20),
              _buildResultCard(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleCard(ThemeData theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.primaryColor,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '${widget.keyword.toUpperCase()} Test Results',
          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildScoreCard(ThemeData theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.primaryColor,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Your score: ${widget.result}',
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildResultCard(ThemeData theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.primaryColor,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          showResult(widget.result, widget.keyword),
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String showResult(int result, String keyword) {
    String level;
    switch (keyword) {
      case "anxiety":
        level = anxietyResult(result);
        break;
      case "depression":
        level = depressionResult(result);
        break;
      case "adhd":
        level = adhdResult(result);
        break;
      case "ptsd":
        level = ptsdResult(result);
        break;
      case "bipolar":
        level = bipolarResult(result);
        break;
      case "parenttest":
        level = bipolarResult(result);
        break;
      default:
        level = "Not defined";
    }
    return level;
  }

  String anxietyResult(int result) {
    if (result > 14) return "Severe Anxiety";
    if (result > 9) return "Moderate Anxiety";
    if (result > 4) return "Mild Anxiety";
    return "Minimal Anxiety";
  }

  String depressionResult(int result) {
    if (result > 19) return "Severe depression";
    if (result > 14) return "Moderately severe depression";
    if (result > 9) return "Moderate depression";
    if (result > 4) return "Mild depression";
    return "Minimal Depression";
  }

  String ptsdResult(int result) {
    return result > 3 ? "PTSD Positive" : "Nah You're fine";
  }

  String adhdResult(int result) {
    return result >= 4 ? "ADHD Likely" : "ADHD Unlikely";
  }

  String bipolarResult(int result) {
    return result > 7 ? "Bipolar Positive" : "Bipolar Negative";
  }
}
