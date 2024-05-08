import 'package:flutter/material.dart';

class SelfHelpScreen extends StatefulWidget {
  const SelfHelpScreen({super.key});

  @override
  State<SelfHelpScreen> createState() => _SelfHelpScreenState();
}

class _SelfHelpScreenState extends State<SelfHelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,color: Colors.white)
        ),
        title: const Text("If you wouldn't Help Yourself noone will",style: TextStyle(color: Colors.white,fontSize: 17),),
        backgroundColor: const Color.fromARGB(255, 1, 47, 114),
      ),
    );
  }
}