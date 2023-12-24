import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import '../chat.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 1,
      child: InkWell(
        //onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),
          title: Text('Demo User'),
          subtitle: Text(
            'Last User message',
            maxLines: 1,
          ),
          trailing: Text(
            '12:00 PM',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
