import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takecare/screens/chat_screen.dart';
import 'package:takecare/widgets/messages.dart';

class ChatScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatMessages(),
      child: ChatScreen(),
    );
  }
}
