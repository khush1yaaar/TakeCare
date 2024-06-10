import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:takecare/screens/Test%20Screens/adhd_test.dart';
import 'package:takecare/screens/Test%20Screens/anxiety_test.dart';
import 'package:takecare/screens/Test%20Screens/bipolar_test.dart';
import 'package:takecare/screens/Test%20Screens/depression_test.dart';
import 'package:takecare/screens/Test%20Screens/ptsd_test.dart';

// ignore: must_be_immutable
class AssessmentScreen extends StatefulWidget {
  String id = 'assessment-screen';
  AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white)
        ),
        title: const Text('Time to know YourSelf better',style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 49, 162, 197),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> AnxietyTest(keyword: "anxiety",))
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 120,
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 49, 162, 197),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: const Center(
                    child: Text(
                      'Anxiety',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    )
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> ADHDTest(keyword: "adhd",))
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 120,
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 49, 162, 197),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: const Center(
                    child: Text(
                      'ADHD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    )
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> DepressionTest(keyword: "depression",))
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 120,
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 49, 162, 197),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: const Center(
                    child: Text(
                      'Depression',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    )
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> BiPolarTest(keyword: "bipolar",))
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 120,
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 49, 162, 197),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: const Center(
                    child: Text(
                      'Bi Polar Disorder',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    )
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> PTSDTest(keyword: "ptsd",))
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 120,
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 49, 162, 197),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: const Center(
                    child: Text(
                      'PTSD Test',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    )
                  ),
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: (){
            //     Navigator.push(
            //       context, 
            //       MaterialPageRoute(builder: (context)=> PTSDTest(keyword: "parenttest",))
            //     );
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Container(
            //       height: 120,
            //       width: 370,
            //       decoration: BoxDecoration(
            //         color: const Color.fromARGB(255, 49, 162, 197),
            //         borderRadius: BorderRadius.circular(15),
            //         boxShadow: const [
            //           BoxShadow(
            //             blurRadius: 15,
            //             blurStyle: BlurStyle.solid,
            //             color: Colors.blueGrey
            //           )
            //         ]
            //       ),
            //       child: const Padding(
            //         padding: EdgeInsets.only(left: 10),
            //         child: Center(
            //           child: Text(
            //             'Parent Test: Your Child’s Mental Health',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 40,
            //             ),
            //           )
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}