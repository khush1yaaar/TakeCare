import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:takecare/Cscreens/api/models/chat_user.dart';
import 'package:takecare/screens/home.dart';
import 'package:takecare/screens/progess.dart';
import 'package:takecare/screens/facts.dart';
//import 'home.dart';
import 'chat.dart';

// ignore: camel_case_types
class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => mainScreenState();
}
  

// ignore: camel_case_types
// class profilex extends ChomeState {
//   static Widget profile() {
//     return Profile(user: ChomeState.list[0]);
//   }
// }

// ignore: camel_case_types
class mainScreenState extends State<mainScreen> {
  // class profilex extends ChomeState {
  //   Widget profile() {
  //     return Profile(user: list[0]);
  //   }
  // }
  //final List<ChatUser> list = [];
  int myIndex = 0;
  List<Widget> widgetlist = const [
    home(),
    chat(),
    facts(),
    progress(),
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
          backgroundColor: Colors.black,
          fixedColor: Colors.white,
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
                    color: Colors.white,
                  ),
                  label: 'home',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  label: 'chat',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  label: 'facts',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.arrow_up_right,
                    //color: Colors.blue,
                  ),
                  label: 'progress',
                  backgroundColor: Colors.black),
            ]),
      ),
    );
  }

  // Widget profile() {
  //   return Profile(user: list[0]);
  // }
}
