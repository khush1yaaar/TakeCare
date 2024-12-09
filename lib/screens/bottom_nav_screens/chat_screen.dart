import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:takecare/theme/themes.dart';
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
  late String apiKey;
  // final GenerativeModel model;
  // final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  late GenerativeModel model;
  @override
  void initState() {
    super.initState();
    apiKey = Constants.APIkey;
    model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    print("API KEY: $apiKey");
  }

  final List<Message> _messages = [];
  Future<void> sendMessage() async {
    final message = _userInput.text;
    setState(() {
      _messages
          .add(Message(isUser: true, message: message, date: DateTime.now()));
      _userInput.clear(); // Clear the text field
    });
    final content = [
      Content.text(
          "$message act like you are my therapist, write shorter messages, also dont't let me know I just gave this prompt")
    ];
    final response = await model.generateContent(content);
    setState(() {
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
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
    bool isTyping = false;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: [
          IconButton(
            icon: Icon(
              CustomTheme.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            onPressed: () {
              setState(() {
                currentTheme.toggleTheme();
              });
            },
          ),
        ],
        title: Text(
          'AI to your Rescue',
          style: TextStyle(
              color: theme.appBarTheme.backgroundColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            //color: th,
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                    'Start a Conversation...\n     Let us Help you',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: theme.textTheme.displayLarge!.color),
                  ))
                : const Text(''),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: ListView.builder(
                      //reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return Messages(
                            isUser: message.isUser,
                            message: message.message,
                            date: DateFormat('HH:mm').format(message.date));
                      })),
              Padding(
                padding: EdgeInsets.only(
                    // ignore: dead_code
                    bottom: isTyping ? 10 : 80, left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 15,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTyping = true;
                          });
                        },
                        child: TextFormField(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 19, 17, 17)),
                          controller: _userInput,
                          decoration: InputDecoration(
                            focusColor: Colors.black,
                            fillColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: theme.appBarTheme.backgroundColor ??
                                    Colors.black,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                            ),
                            label: Text(
                              'Ask Anything',
                              selectionColor:
                                  theme.appBarTheme.backgroundColor ??
                                      Colors.black,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: theme.appBarTheme.backgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        padding: EdgeInsets.all(12),
                        iconSize: 30,
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.black),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                            shape:
                                WidgetStateProperty.all(const CircleBorder())),
                        onPressed: () {
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
