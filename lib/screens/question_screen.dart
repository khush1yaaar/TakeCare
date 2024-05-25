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
    //print('Fetching document for keyword: ${widget.keyword}');
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
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    entry.value.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }).toList();

            return SingleChildScrollView(
              child: Column(
                children: [
                  questionWidgets[0],

                ],
              ),
            );
          }
        },
      ),
    );
  }
}
