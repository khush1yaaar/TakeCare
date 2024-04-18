
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:takecare/provider/auth_provider.dart';
import 'package:takecare/screens/get_started.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 

    ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(), // Provide an instance of AuthProvider
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GetStartedScreen(),
      ),
    );
    // MultiProvider(
    //   providers: [ChangeNotifierProvider(create: (_)=> AuthProvider())],
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     initialRoute: GetStartedScreen.id,
    //     routes: {
    //       HomeScreen.id: (context) =>  const HomeScreen(),
    //       GetStartedScreen.id: (context) => const GetStartedScreen(),
    //     }
    //   ),
    // );
  }
}