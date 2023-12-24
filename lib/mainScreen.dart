import 'package:flutter/material.dart';
import 'package:takecare/home.dart';

import 'facts.dart';
//import 'home.dart';
import 'chat.dart';
import 'profile.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

// ignore: camel_case_types
class _mainScreenState extends State<mainScreen> {
  int myIndex = 0;
  List<Widget> widgetlist = const [
    home(),
    chat(),
    facts(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: myIndex,
          children: widgetlist,
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                myIndex = index;
              });
            },
            currentIndex: myIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    //color: Colors.purple,
                  ),
                  label: 'home',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message,
                    //color: Colors.green,
                  ),
                  label: 'chat',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    //color: Colors.redAccent,
                  ),
                  label: 'facts',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    //color: Colors.blue,
                  ),
                  label: 'profile',
                  backgroundColor: Colors.black),
            ]),
      ),
    );
  }
}
