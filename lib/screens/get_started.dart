import 'package:flutter/material.dart';
import 'package:takecare/screens/login_screen.dart';


class GetStartedScreen extends StatefulWidget {
  static const String id = 'getstarted-screen';
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/images/deliveryboy.png'),
          const SizedBox(
            height: 70,
          ),
          const Text("Let's get started",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 10,
          ),
          const Text('Never a better time than now to Start',style: TextStyle(color: Colors.grey),),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context)=> const LoginScreen()));
                        }, 
                        style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 161, 242, 164)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          ),),
                        ),
                        child: const Text('Get Started', style: TextStyle(fontSize: 16)),),
                            ),
          )
        ],),
    );
  }
}