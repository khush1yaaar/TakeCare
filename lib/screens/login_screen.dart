import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:takecare/screens/home_screen.dart';
import 'package:takecare/widgets/constants.dart';
import 'package:takecare/widgets/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const PageContent(
      imageAsset: 'lib/images/image1.png',
      text: 'Know Your self better',
    ),
    const PageContent(
      imageAsset: 'lib/images/image2.png',
      text: 'heal your self and others',
    ),
    const PageContent(
      imageAsset: 'lib/images/image3.png',
      text: 'be the best version of your self',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 3), () {
      if (_currentPage == _pages.length - 1) {
        _controller.jumpToPage(0);
      } else {
        _controller.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      _startAutoScroll();
    });
  }

  _handleGoogleBtnClick(){
    showProgressBar(context);
    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      if(user != null){
        print('USER ${user.user}');
        print('USER INFO${user.additionalUserInfo}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }
  Future<UserCredential?> _signInWithGoogle() async {
      try{
      await InternetAddress.lookup('google.com');
        // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
      } catch(e){
        print(e);
        showSnackbar(context, 'Something went wrong. Check Internet Connection');
        return null;
      }
    }
    //sign out function
    _signOut() async {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: 100,
              child: PageView(
                controller: _controller,
                children: _pages,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          DotsIndicator(
            dotsCount: _pages.length,
            position: _currentPage,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              activeColor: Color.fromARGB(255, 161, 242, 164),
            ),
          ),
          const SizedBox(height: 50),
          const Text('Ready to feel better?',style: TextStyle(color: Colors.grey,fontSize: 15),),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 161, 242, 164),),
            onPressed: () async {
              _handleGoogleBtnClick();
            },
            icon: Image.asset('lib/images/google.png', height: 30),
            label: RichText(text: 
            const TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(text: 'Sign in with '),
                TextSpan(text: 'Google',style: TextStyle(fontWeight: FontWeight.bold))
              ]
            )),
          ),

          const SizedBox(height: 40),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  final String imageAsset;
  final String text;

  const PageContent({
    required this.imageAsset,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(imageAsset),
          ),
        Text(
          text,
          style: kPageViewTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
