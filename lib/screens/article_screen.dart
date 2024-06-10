import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takecare/screens/player_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class ArticleScreen extends StatefulWidget {
  String article;
  String audio;

  ArticleScreen({key, required this.article, required this.audio});
  
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
    // Replace 'procrastination' with the document ID you want to fetch
    return FirebaseFirestore.instance
        .collection('articles')
        .doc(widget.article)
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchVideo() async {
    // Replace 'procrastination' with the document ID you want to fetch
    return FirebaseFirestore.instance
        .collection('videos')
        .doc(widget.article)
        .get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 200, 236, 247),
      appBar: AppBar(
        title: Text(widget.article),
        backgroundColor: Color.fromARGB(255, 49, 162, 197),
      ),
      body: FutureBuilder(
        future: Future.wait([_articleFuture, _videoFuture]),
        builder: (context, snapshot) {
          
          //------------ YouTube Video data ------------------
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          }

          // Access the article data from snapshot.data
          final videoData = snapshot.data![1].data();
          if (videoData == null || videoData.isEmpty) {
            return const Center(child: Text('Article data is empty'));
          }

          // Access individual fields from articleData
          final videoContent = videoData[widget.article];
          //final String? videoId = YoutubePlayer.convertUrlToId(widget.video);
          
          print('Video content: $videoContent');


          //-------------- Article Data -----------------
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          }

          // Access the article data from snapshot.data
          final articleData = snapshot.data![0].data();
          if (articleData == null || articleData.isEmpty) {
            return const Center(child: Text('Article data is empty'));
          }

          // Access individual fields from articleData
          // final articleContent = articleData[widget.article];
          // print('Article content: $articleContent');


          // Return your UI widgets with fetched data
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                //------------Youtube Video-------------
                
                if (videoData.containsKey(widget.article) && videoData[widget.article] is String)
                  
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=> 
                          PlayerScreen(videoId: YoutubePlayer.convertUrlToId(videoData[widget.article])!)
                        )
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )
                          ),
                          child: Image.network(
                            YoutubePlayer
                            .getThumbnail(
                              videoId: YoutubePlayer.convertUrlToId(videoData[widget.article])!,
                            ),
                            height: 200,
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

                //----------- Article--------------
                if (articleData.containsKey(widget.article) && articleData[widget.article] is String)
                  Text(
                    articleData[widget.article] as String,
                    style: TextStyle(fontSize: 16),
                  ),
                if (articleData.containsKey(widget.article) && articleData[widget.article] is! String)
                  const Text(
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
