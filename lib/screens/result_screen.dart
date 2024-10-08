import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int result;
  final String keyword;
  const Result({super.key,required this.result, required this.keyword});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 162, 197),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white)
        ),
        title: const Text(
          'See Your Results',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  '${widget.keyword.toString().toUpperCase()} Test Results',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ), 
              const SizedBox(
                height: 30,
              ),
              Text(
                'Your score : ${widget.result.toString().toUpperCase()}',
                style: const TextStyle(
                  fontSize: 20
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                showResult(widget.result, widget.keyword),
                style: TextStyle(
                  fontSize: 30
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String showResult(int result, String keyword) {
    String level;
    switch (keyword) { 
      case "anxiety": { 
        level = anxietyResult(result);
      } break;

      case "depression": { 
        level = depressionResult(result);
      } break; 

      case "adhd": { 
        level = adhdResult(result);
      } break;

      case "ptsd": { 
        level = ptsdResult(result);
      } break; 
      
      case "bipolar": { 
        level = bipolarResult(result);
      } break; 
      
      case "parenttest": { 
        level = bipolarResult(result);
      } break; 

      default: { 
        level = "Not defined"; 
      } break; 
    } 
    return level;
  }
  String anxietyResult(int result) {
    String level;
    if(result > 14) {
      level = "Severe Anxiety";
    }
    else if (result > 9) {
      level = "Moderate Anxiety";
    }
    else if ( result > 4) {
      level = "Mild Anxiety";
    }
    else {
      level = "Minimal Anxiety";
    }
    return level;
  }

  String depressionResult(int result) {
    String level;
    if(result > 19) {
      level = "Severe depression";
    }
    else if (result > 14) {
      level = "Moderately severe depression";
    }
    else if ( result > 9) {
      level = "Moderate depression";
    }
    else if ( result > 4) {
      level = "Mild depression";
    }
    else {
      level = "Minimal Anxiety";
    }
    return level;
  }

  String ptsdResult(int result) {
    String level;
    if(result > 3) {
      level = "PTSD Positive";
    }
    else {
      level = "Nah You're fine";
    }
    return level;
  }
  String adhdResult(int result) {
    String level;
    if(result >= 4) {
      level = "ADHD Likely";
    }
    else {
      level = "ADHD Unlikely";
    }
    return level;
  }
  String bipolarResult(int result) {
    String level;
    if(result > 7) {
      level = "BiPolar Positive";
    }
    else {
      level = "BiPolar Negative";
    }
    return level;
  }
}