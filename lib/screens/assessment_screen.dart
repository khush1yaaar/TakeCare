import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromARGB(255, 1, 47, 114),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('Anxiety',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('  Panick    \n   Attack',style: TextStyle(color: Colors.white,fontSize: 35),)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('Depression',style: TextStyle(color: Colors.white,fontSize: 30),)),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('PTSD',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('Addiction',style: TextStyle(color: Colors.white,fontSize: 35),)),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('OCD',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('   Eating \nDisorder',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('Stress',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('  BiPolar \n DisOrder',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('   Sleep \nDisorder',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('ADHD',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('Schizophrenia',style: TextStyle(color: Colors.white,fontSize: 25),)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('Paranoia',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('Personality \ndisorders',style: TextStyle(color: Colors.white,fontSize: 25),)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('Adjustment \ndisorders',style: TextStyle(color: Colors.white,fontSize: 25),)),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('   Gender \ndysphoria',style: TextStyle(color: Colors.white,fontSize: 30),)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('BPD',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 130,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 80, 152),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                    ),
                    child: const Center(child: Text('SAD',style: TextStyle(color: Colors.white,fontSize: 40),)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}