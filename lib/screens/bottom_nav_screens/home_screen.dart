import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takecare/screens/article_screen.dart';
import 'package:takecare/screens/assessment_screen.dart';
import 'package:takecare/screens/emotion_detection_screen.dart';
import 'package:takecare/screens/selfhelp_screen.dart';
import 'package:takecare/theme/themes.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //late Future<DocumentSnapshot<Map<String, dynamic>>> _nameFuture;

  @override
  void initState() {
    super.initState();
    //_nameFuture = _fetchName();
  }

  // Future<DocumentSnapshot<Map<String, dynamic>>> _fetchName() async {
  //   return FirebaseFirestore.instance.collection('users').doc('name').get();
  // }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              CustomTheme.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            onPressed: () {
              setState(() {
                Provider.of<CustomTheme>(context, listen: false).toggleTheme();
              });
            },
          ),
        ],
        title: GestureDetector(
          onTap: () {},
          child: Text(
            ' Hello, There!',
            style: TextStyle(
              color: theme.appBarTheme.backgroundColor,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
        ), 
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection(
              context,
              title: 'Self Assessment',
              image: 'lib/images/therapy.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AssessmentScreen()),
              ),
            ),
            _buildSection(
              context,
              title: 'Self Help Tools',
              image: 'lib/images/puzzle.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelfHelpScreen()),
              ),
            ),
            _buildSection(
              context,
              title: 'Emotion Detection',
              image: 'lib/images/therapy.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmotionDetectionScreen()),
              ),
            ),
            _buildArticleSection(
              context,
              title: 'Procrastination',
              image: 'lib/images/stress.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ArticleScreen(article: 'procrastination', audio: '')),
              ),
            ),
            _buildArticleSection(
              context,
              title: 'Self Esteem',
              image: 'lib/images/selfimage.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ArticleScreen(article: 'self-esteem', audio: '')),
              ),
            ),
            _buildArticleSection(
              context,
              title: 'Self Acceptance',
              image: 'lib/images/burnout.png',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ArticleScreen(article: 'self-acceptance', audio: '')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title,
      required String image,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor, // Medium grey container
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: Theme.of(context).appBarTheme.backgroundColor ?? Colors.black, // Slightly darker grey shadow
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(image, height: 150),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color ?? Colors.white, // Light grey text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleSection(BuildContext context,
      {required String title,
      required String image,
      required VoidCallback onTap}) {
    return _buildSection(context, title: title, image: image, onTap: onTap);
  }
}
