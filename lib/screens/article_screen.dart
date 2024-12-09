import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takecare/screens/player_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class ArticleScreen extends StatefulWidget {
  String article;
  String audio;

  ArticleScreen({Key? key, required this.article, required this.audio})
      : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _articleFuture;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _videoFuture;

  @override
  void initState() {
    super.initState();
    _articleFuture = _fetchArticle();
    _videoFuture = _fetchVideo();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchArticle() async {
    return FirebaseFirestore.instance
        .collection('articles')
        .doc(widget.article)
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchVideo() async {
    return FirebaseFirestore.instance
        .collection('videos')
        .doc(widget.article)
        .get();
  }

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
          widget.article,
          style: TextStyle(
            color: theme.appBarTheme.backgroundColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: FutureBuilder(
        future: Future.wait([_articleFuture, _videoFuture]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          }

          final articleData = snapshot.data![0].data();
          final videoData = snapshot.data![1].data();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (videoData != null && videoData.containsKey(widget.article))
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                            videoId: YoutubePlayer.convertUrlToId(
                                videoData[widget.article])!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.appBarTheme.backgroundColor ??
                                Colors.black,
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              YoutubePlayer.getThumbnail(
                                videoId: YoutubePlayer.convertUrlToId(
                                    videoData[widget.article])!,
                              ),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (articleData != null &&
                    articleData.containsKey(widget.article))
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color:
                              theme.appBarTheme.backgroundColor ?? Colors.black,
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: articleData[widget.article].toString().split('\n').map((paragraph) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 12), // Add spacing between paragraphs
                          child: Text(
                            paragraph
                                .trim(), // Trim unnecessary spaces or newlines
                            style: TextStyle(
                              color: theme.appBarTheme.backgroundColor,
                              fontSize: 16,
                              height: 1.5, // Line height for better readability
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                if (articleData == null ||
                    !articleData.containsKey(widget.article))
                  const Text(
                    'No article content available',
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
