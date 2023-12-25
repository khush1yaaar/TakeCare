import 'package:flutter/material.dart';
import 'package:takecare/splash_screen.dart';
//import 'Cscreens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int myIndex = 0;
//   List<Widget> widgetlist = const [
//     LoginScreen(),
//     chat(),
//     facts(),
//     profile(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: IndexedStack(
//           index: myIndex,
//           children: widgetlist,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//             onTap: (index) {
//               setState(() {
//                 myIndex = index;
//               });
//             },
//             currentIndex: myIndex,
//             items: const [
//               BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.home,
//                     //color: Colors.purple,
//                   ),
//                   label: 'home',
//                   backgroundColor: Colors.black),
//               BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.message,
//                     //color: Colors.green,
//                   ),
//                   label: 'chat',
//                   backgroundColor: Colors.black),
//               BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.favorite,
//                     //color: Colors.redAccent,
//                   ),
//                   label: 'facts',
//                   backgroundColor: Colors.black),
//               BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.person,
//                     //color: Colors.blue,
//                   ),
//                   label: 'profile',
//                   backgroundColor: Colors.black),
//             ]),
//       ),
//     );
//   }
// }
