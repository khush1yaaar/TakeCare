import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takecare/screens/player_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelfHelpScreen extends StatefulWidget {
  const SelfHelpScreen({super.key});

  @override
  State<SelfHelpScreen> createState() => _SelfHelpScreenState();
}

class _SelfHelpScreenState extends State<SelfHelpScreen> {
  final CollectionReference selfHelpCollection =
      FirebaseFirestore.instance.collection('selfhelp');

  Future<String?> fetchVideoTitle(String videoId) async {
    const apiKey = 'AIzaSyDbEkG0tCR_vJ89kDlF-nh4-HSgXkQSMaQ'; // Replace with your API key
    final url =
        'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['items'][0]['snippet']['title'];
      }
    } catch (error) {
      print("Error fetching video title: $error");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "One Step at a time",
          style: TextStyle(
              color: theme.appBarTheme.backgroundColor,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: StreamBuilder(
        stream: selfHelpCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching videos'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No videos found'));
          }

          final videoDocs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: videoDocs.length,
            itemBuilder: (context, index) {
              final videoData = videoDocs[index].data() as Map<String, dynamic>;
              final videoUrl = videoData.values.first;
              final videoId = YoutubePlayer.convertUrlToId(videoUrl);

              if (videoId == null) {
                print("Invalid video URL: $videoUrl");
                return const SizedBox.shrink(); // Skip invalid URLs
              }

              return FutureBuilder<String?>(
                future: fetchVideoTitle(videoId),
                builder: (context, titleSnapshot) {
                  final videoTitle = titleSnapshot.data ?? "Loading...";

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(videoId: videoId),
                        ),
                      );
                    },
                    child: Card(
                      color: theme.appBarTheme.backgroundColor,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                YoutubePlayer.getThumbnail(videoId: videoId),
                                fit: BoxFit.cover,
                                height: 90,
                                width: 120,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    videoTitle,
                                    style: TextStyle(
                                      color: theme.textTheme.bodyLarge!.color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Tap to watch video",
                                    style: TextStyle(
                                      color: theme.textTheme.bodySmall!.color,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
