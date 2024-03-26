// import 'dart:io';
// import 'dart:math';

// import 'package:firebase_auth/firebase_auth.dart';
//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:takecare/auth/login_screen.dart';
import 'package:takecare/screens/chat.dart';
import 'package:takecare/screens/mainScreen.dart';

import '../api/apis.dart';
// import 'package:takecare/helper/dialogs.dart';
// import 'package:takecare/mainScreen.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if(APIs.auth.currentUser != null){
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const mainScreen()));
      }else{
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  // _handleGoogleBtnClick() {
  //   Dialogs.showProgressBar(context);
  //   _signInWithGoogle().then((user) {
  //     Navigator.pop(context);
  //     if (user != null) {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  //       log('\nUser:${user.user}' as num);
  //       log('\nUserAdditionInfo:${user.additionalUserInfo}' as num);
  //     }
  //   });
  // }

  // Future<UserCredential?> _signInWithGoogle() async {
  //   try {
  //     await InternetAddress.lookup('google.com');
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     return FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     log('\n_signInWithGoogle():$e' as num);
  //     // ignore: use_build_context_synchronously
  //     Dialogs.showSnackBar(context, 'Something went wrong(Check Internet)');
  //   }
  //   return null;
  // }

  // _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   await GoogleSignIn().signOut();
  // }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Welcome to TakeCare',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Stack(children: [
        Positioned(
          top: mq.height * .15,
          right: mq.width * .25,
          width: mq.width * .5,
          child: Image.asset('assets/images/logo3.jpg'),
        ),
        Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: const Center(
              child: Text(
                'Google Workspace',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 44, 43, 43),
                    fontSize: 25),
              ),
            )),
      ]),
    );
  }
}
