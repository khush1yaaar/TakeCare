import 'dart:math';

import 'package:flutter/src/widgets/navigator.dart';
import 'dart:io';
//import 'dart:math';
//import '../../api/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takecare/chat.dart';
import 'package:takecare/Cscreens/helper/dialogs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:takecare/mainScreen.dart';

import '../api/apis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleBtnClick() {
    //Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      if (user != null) {
        //Navigator.pop(context);

        log('\nUser:${user.user}' as num);
        log('\nUserAdditionInfo:${user.additionalUserInfo}' as num);

        if (await APIs.userExits()) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const mainScreen()));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const mainScreen()));
          });
        }

        // if ((await APIs.userExists())) {
        //   // ignore: use_build_context_synchronously
        //   Navigator.pushReplacement(
        //       context, MaterialPageRoute(builder: (_) => const home()));
        // } else {
        //   await APIs.createUser().then((value) {
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (_) => const home()));
        //   });
        // }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle():$e' as num);
      // ignore: use_build_context_synchronously
      Dialogs.showSnackBar(context, 'Something went wrong(Check Internet)');
      return null;
    }
  }

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
        AnimatedPositioned(
          top: mq.height * .15,
          right: _isAnimate ? mq.width * .25 : -mq.width * .5,
          width: mq.width * .5,
          duration: const Duration(seconds: 1),
          child: Image.asset('assets/images/logo3.jpg'),
        ),
        Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .07,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 223, 255, 187)),
                onPressed: () {
                  _handleGoogleBtnClick();
                },
                icon: Image.asset(
                  'assets/images/google.png',
                  height: mq.height * .03,
                ),
                label: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Sign In with '),
                        TextSpan(
                            text: 'Google',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                ))),
      ]),
    );
  }
}
