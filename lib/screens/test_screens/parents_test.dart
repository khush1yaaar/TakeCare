import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:takecare/screens/result_screens/result_screen.dart';

// ignore: must_be_immutable
class AnxietyTest extends StatefulWidget {
  String keyword;

  AnxietyTest({super.key, required this.keyword});

  @override
  State<AnxietyTest> createState() => _AnxietyTestState();
}

class _AnxietyTestState extends State<AnxietyTest> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _questionFuture;
  int ans = 0;
  int index = 0;
  int result = 0;
  @override
  void initState() {
    super.initState();
    _questionFuture = _fetchQuestion();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchQuestion() async {
    //print('Fetching document for keyword: ${widget.keyword}');
    return FirebaseFirestore.instance
        .collection('Questions')
        .doc(widget.keyword)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white)
        ),
        backgroundColor: Color.fromARGB(255, 49, 162, 197),
        title: const  Text('Self Assessment',style: TextStyle(color: Colors.white),),
      ),
      //--------------------------FETCHING QUESTIONS FROM DATABASE-----------------------------------
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            //print('Document does not exist for keyword: ${widget.keyword}');
            return const Center(child: Text('Document does not exist'));
          } else {
            // Extract the fields from the document
            Map<String, dynamic> data = snapshot.data!.data()!;
            if (data.isEmpty) {
              return const Center(child: Text('No questions found'));
            }
            List<Widget> questionWidgets = data.entries.map((entry) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${index+1}',
                          style: const TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            entry.value.toString(),
                            style: const TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  //---------------------- OPTIONS --------------------------
                  SizedBox(
                    height: 40,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        ans = 0;
                      }, 
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 49, 162, 196)),
                      ),
                      child: const Text('Never',style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 40,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        ans = 1;
                      }, 
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 49, 162, 196)),
                      ),
                      child: const Text('Some Times',style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 40,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        ans = 2;
                      }, 
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 49, 162, 196)),
                      ),
                      child: const Text('Often',style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 170,left: 200),
                    child: SizedBox(
                      height: 70,
                      width: 100,
                      child: FloatingActionButton(
                        backgroundColor: Color.fromARGB(255, 49, 162, 196),
                        onPressed: () {
                          _movedToNextScreen();
                        },
                        child: const Text('Next Question',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                ],
              );
            }).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    questionWidgets[index],
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
  void _movedToNextScreen() {
    if(index < 6) {
      setState(() {
        result = result + ans;
        index = index + 1;
        _questionFuture = _fetchQuestion(); // Re-fetch the next question
      });
    }
    else {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: ((context) => Result(result: result,keyword : widget.keyword)))
      );
    }
  }
}
