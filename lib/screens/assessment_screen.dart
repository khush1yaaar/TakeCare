import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takecare/screens/test_screens/adhd_test.dart';
import 'package:takecare/screens/test_screens/anxiety_test.dart';
import 'package:takecare/screens/test_screens/bipolar_test.dart';
import 'package:takecare/screens/test_screens/depression_test.dart';
import 'package:takecare/screens/test_screens/ptsd_test.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: theme.appBarTheme.backgroundColor,
            )),
        title: Text(
          'Time to know YourSelf better',
          style: TextStyle(
            color: theme.appBarTheme.backgroundColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCard(
              'Anxiety',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnxietyTest(keyword: "anxiety"),
                  ),
                );
              },
            ),
            buildCard(
              'ADHD',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ADHDTest(keyword: "adhd"),
                  ),
                );
              },
            ),
            buildCard(
              'Depression',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DepressionTest(keyword: "depression"),
                  ),
                );
              },
            ),
            buildCard(
              'Bi Polar Disorder',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BiPolarTest(keyword: "bipolar"),
                  ),
                );
              },
            ),
            buildCard(
              'PTSD Test',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PTSDTest(keyword: "ptsd"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 120,
          width: 370,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                blurRadius: 15,
                blurStyle: BlurStyle.solid,
                color: Colors.blueGrey,
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
