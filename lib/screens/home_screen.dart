import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:takecare/screens/article_screen.dart';
import 'package:takecare/screens/assessment_screen.dart';
import 'package:takecare/screens/selfhelp_screen.dart';
import 'package:takecare/widgets/utils.dart';


class HomeScreen extends StatefulWidget {
  static String id = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String name = '';
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){
           name = _nameInputPopUp(context);
          },
          child: Text(name.length == 0?
            'Hello, There!':'Hello, $name',
            style: TextStyle(color: Colors.white),)
        ),
        backgroundColor: Color.fromARGB(255, 1, 47, 114),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AssessmentScreen()),
                  );
                },
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset('lib/images/therapy.png',height: 250,)),
                      const Text(
                        'Self Assessment',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ),
                  
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> const SelfHelpScreen()
                    )
                  );
                },
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Image.asset('lib/images/puzzle.png',height: 150,)),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Text(
                          '   Self Help Tools',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 1,
              width: 350,
              color: Colors.grey,
            ),

            //------------------ ARTICLE - 1 --------------
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> ArticleScreen(article:'procrastination',audio: ''))
                  );
                },
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Image.asset('lib/images/stress.png',height: 150,)),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Text(
                          '   Procrastination',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //-------------- ARTICLE - 2 -----------------
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> ArticleScreen(article: 'self-esteem', audio: ''))
                  );
                },
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Image.asset('lib/images/selfimage.png',height: 150,)),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Text(
                          '        Self Image',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //------------------ ARTICLE - 3 --------------
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> ArticleScreen(article:'self-acceptance',audio: ''))
                  );
                },
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Image.asset('lib/images/burnout.png',height: 150,)),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Text(
                          '         BurnOut',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: (){
                  
                },
                child: Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        blurStyle: BlurStyle.solid,
                        color: Colors.blueGrey
                      )
                    ]
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Image.asset('lib/images/stress.png',height: 150,)),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Text(
                          '   Procrastination',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _nameInputPopUp(BuildContext context) {
    //Dialogs dialog = Dialogs();
    Dialogs.inputDialog(context, 'Entre Your Name');
    String name = Dialogs.userInput.text;
    return name;
  }
}