import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:provider/provider.dart';
import 'package:takecare/provider/auth_provider.dart';
import 'package:takecare/screens/bottom_nav_screens/bottom_nav.dart';
import 'package:takecare/screens/auth_screens/get_started.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SpringSimulation _simulation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: double.infinity,
    );
    _simulation = SpringSimulation(
      SpringDescription(
        mass: 0.5,
        stiffness: 100,
        damping: 10,
      ),
      0, // initial position
      0, // target position
      0, // initial velocity
    );
    _controller.animateWith(_simulation);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation has completed, navigate to another screen
        navigateToNextScreen();
      }
    });
  }

  void navigateToNextScreen() async {
    final isUserLoggedIn = await Provider.of<AuthProvider>(context, listen: false).checkLoggedIn();
    if (isUserLoggedIn) {
      Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (context) => const BottomNavBar())
      );
    } else {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const GetStartedScreen())
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(1, _controller.value - 300),
            child: Center(
              child: Image.asset(
                'lib/images/launch_image.jpg',
                width: 150,
                height: 150,
              ),
            ),
          );
        },
      ),
    );
  }
}