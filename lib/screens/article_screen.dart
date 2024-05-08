import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  final String heading;
  final String article;

  ArticleScreen({Key? key, required this.heading, required this.article})
      : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _articleFuture;

  @override
  void initState() {
    super.initState();
    _articleFuture = _fetchArticle();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchArticle() async {
    // Replace 'procrastination' with the document ID you want to fetch
    return FirebaseFirestore.instance
        .collection('articles')
        .doc('procrastination')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.heading),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          }

          // Access the article data from snapshot.data
          final articleData = snapshot.data!.data();
          if (articleData == null || articleData.isEmpty) {
            return Center(child: Text('Article data is empty'));
          }

          // Access individual fields from articleData
          final articleContent = articleData['procrastination'];

          print('Article content: $articleContent');

          // Return your UI widgets with fetched data
          return SingleChildScrollView(
  padding: EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (articleData.containsKey('procrastination') && articleData['procrastination'] is String)
        Text(
          articleData['procrastination'] as String,
          style: TextStyle(fontSize: 16),
        ),
      if (articleData.containsKey('procrastination') && articleData['procrastination'] is! String)
        Text(
          'Invalid article content format',
          style: TextStyle(fontSize: 16),
        ),
    ],
  ),
);

        },
      ),
    );
  }
}
