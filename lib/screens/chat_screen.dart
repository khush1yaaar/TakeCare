import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:takecare/widgets/constants.dart';
import 'package:takecare/widgets/messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _userInput = TextEditingController();
  final ScrollController _scrollController = ScrollController(); 
  final apiKey = Constants.APIkey;
  //final GenerativeModel model;
  //final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey.toString());
  late final GenerativeModel model;
  @override
  void initState() {
    super.initState();
    final apiKey = Constants.APIkey;
    model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey.toString());
  }
  final List<Message> _messages = [];
  Future<void> sendMessage() async{
    final message = _userInput.text;
    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
      _userInput.clear(); // Clear the text field
    });
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      _messages.add(Message(isUser: false, message: response.text?? "", date: DateTime.now()));
    });
    _scrollToBottom();
  }
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 75, 165),
        leading: GestureDetector(
          onTap: (){
            //Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Color.fromARGB(255, 15, 75, 165))
        ),
        title: const Text(
          'AI to your Rescue',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: 
            Container(
              color: Colors.blue.shade50,
              child: _messages.isEmpty ? 
                     const Center(
                      child: Text(
                        'Start a Conversation...\n     Let us Help you',
                        style: TextStyle(fontWeight: FontWeight.w200,fontSize: 20),
                        )): 
                       Text(''),
            )
            // Image.asset(
            //   'lib/images/image4.jpeg',
            //   fit: BoxFit.cover,
            //   colorBlendMode: BlendMode.dstATop,
            //   color: Colors.white.withOpacity(0.8),
            // ),
          ),
          Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: ListView.builder(
                  //reverse: true,
                  itemCount:_messages.length,
                  itemBuilder: (context,index){
                  final message = _messages[index];
                  return Messages(isUser: message.isUser, message: message.message, date: DateFormat('HH:mm').format(message.date));
                })
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _userInput,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        fillColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.blue.shade700, 
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid
                          )
                        ),
                        label: const Text('Ask Anything')
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.all(12),
                      iconSize: 30,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(CircleBorder())
                      ),
                      onPressed: (){
                      sendMessage();
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
        ],
      ),
    );
  }
}
