import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takecare/models/chat_user.dart';

import '../screens/chat.dart';
// import 'package:takecare/lib/Cscreens/models/chat_user.dart';

// import '../chat.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        //onTap: () {},
        child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(mq.width * 0.6),
              child: CachedNetworkImage(
                width: mq.width * 0.055,
                height: mq.height * 0.055,
                imageUrl: widget.user.image,
                //placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(CupertinoIcons.person),
                ),
              ),
            ),
            title: Text(widget.user.name),
            subtitle: Text(
              widget.user.about,
              maxLines: 1,
            ),
            trailing: ClipRRect(
              borderRadius: BorderRadius.circular(30),
                child: Container(
              width: 15,
              height: 15,
              color: widget.user.isOnline ? Colors.green : const Color.fromARGB(23, 255, 255, 255),
            ))
            // trailing: const Text(
            //   '12:00 PM',
            //   style: TextStyle(color: Colors.black54),
            // ),
            ),
      ),
    );
  }
}
