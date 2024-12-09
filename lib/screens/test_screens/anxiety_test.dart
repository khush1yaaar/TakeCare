import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takecare/screens/result_screens/result_screen.dart';
import 'package:takecare/widgets/option.dart';

class AnxietyTest extends StatefulWidget {
  final String keyword;

  AnxietyTest({super.key, required this.keyword});

  @override
  State<AnxietyTest> createState() => _AnxietyTestState();
}

class _AnxietyTestState extends State<AnxietyTest> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _questionFuture;
  int ans = -1;
  int index = 0;
  int result = 0;
  List<bool> isSelected = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _questionFuture = _fetchQuestion();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchQuestion() async {
    return FirebaseFirestore.instance
        .collection('Questions')
        .doc(widget.keyword)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Anxiety Test',
          style: TextStyle(
            color: theme.appBarTheme.backgroundColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: theme.textTheme.bodyLarge!.color,));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Document does not exist'));
          } else {
            Map<String, dynamic> data = snapshot.data!.data()!;
            if (data.isEmpty) {
              return const Center(child: Text('No questions found'));
            }
            List<Widget> questionWidgets = data.entries.map((entry) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}.',
                          style: TextStyle(
                              color: theme.appBarTheme.backgroundColor,
                              fontSize: 25),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            entry.value.toString(),
                            style: TextStyle(
                                color: theme.appBarTheme.backgroundColor,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Option(
                        option: 'Not at All',
                        isSelected: isSelected[0],
                        onTap: () => _selectOption(0),
                      ),
                      Option(
                        option: 'Several Days',
                        isSelected: isSelected[1],
                        onTap: () => _selectOption(1),
                      ),
                      Option(
                        option: 'More than Half the Days',
                        isSelected: isSelected[2],
                        onTap: () => _selectOption(2),
                      ),
                      Option(
                        option: 'Nearly Every Day',
                        isSelected: isSelected[3],
                        onTap: () => _selectOption(3),
                      ),
                      ans != -1
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 170, left: 200),
                              child: SizedBox(
                                height: 60,
                                width: 130,
                                child: FloatingActionButton.extended(
                                  backgroundColor:
                                      theme.appBarTheme.backgroundColor,
                                  onPressed: _moveToNextScreen,
                                  label: const Text(
                                    'Next Question',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
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

  void _selectOption(int selectedIndex) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = i == selectedIndex;
      }
      ans = selectedIndex;
    });
  }

  void _moveToNextScreen() {
    if (index < 6) {
      setState(() {
        result += ans;
        index++;
        isSelected = [false, false, false, false]; // Reset options
        ans = -1;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Result(result: result, keyword: widget.keyword),
        ),
      );
    }
  }
}
