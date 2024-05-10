import 'package:flutter/material.dart';
import 'package:takecare/screens/player_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final videoUrls = [
  'https://youtu.be/1W7oUZ8EVbI?si=oBN35rANx6q4vx4y',
  'https://youtu.be/86sYinrLuPA?si=VW9igD4YfsBanmER',
  'https://youtu.be/-lOTZRpOvxY?si=vntC-CD_N8IKOzn3',
  'https://youtu.be/j5qgaKHMw1I?si=eF41WuIv9FBjSe-h',
  'https://youtu.be/b2RhXCugEW4?si=IzR9c4cZEsUHNGWf',
  'https://youtu.be/qX5_JLl3wYg?si=zFpEDI7HRQ3orEiO',
  'https://youtu.be/XOoFuiLeaPg?si=TJf_5JS-FVL-sekJ',
];
class SelfHelpScreen extends StatefulWidget {
  const SelfHelpScreen({super.key});

  @override
  State<SelfHelpScreen> createState() => _SelfHelpScreenState();
}

class _SelfHelpScreenState extends State<SelfHelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,color: Colors.white)
        ),
        title: const Text("If you wouldn't Help Yourself noone will",style: TextStyle(color: Colors.white,fontSize: 17),),
        backgroundColor: const Color.fromARGB(255, 1, 47, 114),
      ),
      body: Padding(
        padding: EdgeInsets.zero,
        child: ListView.builder(
          itemCount: videoUrls.length,
          itemBuilder: (context, index) {
            final videoId = YoutubePlayer.convertUrlToId(videoUrls[index]);
        
            return InkWell(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> 
                    PlayerScreen(videoId: videoId)
                  )
                );
              },
              child: Padding(
                padding: EdgeInsets.zero,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(YoutubePlayer.getThumbnail(videoId: videoId!)),
                    const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}