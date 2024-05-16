// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class Question extends StatefulWidget {
//   String keyword;
  
//   Question({super.key,required this.keyword});

//   @override
//   State<Question> createState() => _QuestionState();
// }

// class _QuestionState extends State<Question> {
//   late Future<DocumentSnapshot<Map<String, dynamic>>> _questionFuture;
//   @override
//   void initState() {
//     // TODO: implement initState
//     _questionFuture = _fetchQuestion();
//     super.initState();
//   }

//   Future<DocumentSnapshot<Map<String, dynamic>>> _fetchQuestion() async {
//     // Replace 'procrastination' with the document ID you want to fetch
//     return FirebaseFirestore.instance
//         .collection('questions')
//         .doc(widget.keyword)
//         .get();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const Text(
//               '',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//               ),
//             ),
//             GestureDetector(
//               onTap: (){},
//               child: Container(
//                 color: Colors.blue.shade400,
//                 child: const Text(
//                   '-----------Option 1------------',
//                   style: TextStyle(color: Colors.black,fontSize: 15),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class Question extends StatefulWidget {
//   String keyword;

//   Question({super.key, required this.keyword});

//   @override
//   State<Question> createState() => _QuestionState();
// }

// class _QuestionState extends State<Question> {
//   late Future<DocumentSnapshot<Map<String, dynamic>>> _questionFuture;
//   int result = 0;
//   @override
//   void initState() {
//     super.initState();
//     _questionFuture = _fetchQuestion();
//   }

//   Future<DocumentSnapshot<Map<String, dynamic>>> _fetchQuestion() async {
//     return FirebaseFirestore.instance
//         .collection('Questions')
//         .doc(widget.keyword)
//         .get();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.keyword),
//       ),
//       body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//         future: _questionFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text('Document does not exist'));
//           } else {
//             // Extract the fields from the document
//             Map<String, dynamic> data = snapshot.data!.data()!;
//             List<Widget> questionWidgets = data.entries.map((entry) {
//               return Column(
//                 children: [
//                   Text(
//                     entry.key,
//                     style: TextStyle(color: Colors.black, fontSize: 18),
//                   ),
//                   Text(
//                     entry.value.toString(),
//                     style: TextStyle(color: Colors.black, fontSize: 15),
//                   ),
//                   SizedBox(height: 10),
//                 ],
//               );
//             }).toList();

//             return SingleChildScrollView(
//               child: Column(
//                 children: questionWidgets,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Question extends StatefulWidget {
  String keyword;

  Question({super.key, required this.keyword});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _questionFuture;

  @override
  void initState() {
    super.initState();
    _questionFuture = _fetchQuestion();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchQuestion() async {
    print('Fetching document for keyword: ${widget.keyword}');
    return FirebaseFirestore.instance
        .collection('Questions')
        .doc(widget.keyword)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Self Assessment'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            print('Document does not exist for keyword: ${widget.keyword}');
            return Center(child: Text('Document does not exist'));
          } else {
            // Extract the fields from the document
            Map<String, dynamic> data = snapshot.data!.data()!;
            if (data.isEmpty) {
              return Center(child: Text('No questions found'));
            }
            List<Widget> questionWidgets = data.entries.map((entry) {
              return Column(
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    entry.value.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  SizedBox(height: 10),
                ],
              );
            }).toList();

            return SingleChildScrollView(
              child: Column(
                children: questionWidgets,
              ),
            );
          }
        },
      ),
    );
  }
}
