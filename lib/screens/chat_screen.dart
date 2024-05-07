import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:takecare/widgets/messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _userInput = TextEditingController();
  final ScrollController _scrollController = ScrollController(); 
  final apiKey = 'AIzaSyCrto_gzRkC9hhywRqcu0sDNCjWsKsGnxk';

  final model = GenerativeModel(model: 'gemini-pro', apiKey: 'AIzaSyCrto_gzRkC9hhywRqcu0sDNCjWsKsGnxk');
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
    //_scrollToBottom();
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
        backgroundColor: Color.fromARGB(255, 1, 47, 114),
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
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black,style: BorderStyle.solid)
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


// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _userInput = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final apiKey = 'AIzaSyCrto_gzRkC9hhywRqcu0sDNCjWsKsGnxk'; // Replace with your API key
//   final model = GenerativeModel(model: 'gemini-pro', apiKey: 'YOUR_API_KEY_HERE'); // Replace with your API key
//   final List<Message> _messages = [];

//   Future<void> sendMessage() async {
//     final message = _userInput.text;
//     setState(() {
//       _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
//       _userInput.clear(); // Clear the text field
//     });
//     final content = [Content.text(message)];
//     final response = await model.generateContent(content);
//     setState(() {
//       _messages.add(Message(isUser: false, message: response.text ?? "", date: DateTime.now()));
//       _scrollToBottom();
//     });
//     _scrollToBottom();
//   }

//   void _scrollToBottom() {
//     _scrollController.animateTo(
//       _scrollController.position.minScrollExtent,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.bounceIn,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 1, 47, 114),
//         title: const Text(
//           'Get Accurate Answers All You want',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Container(
//               color: Colors.blue.shade50,
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   reverse: false, // Start from the bottom
//                   itemCount: _messages.length,
//                   itemBuilder: (context, index) {
//                     final message = _messages[index];
//                     return Messages(
//                       isUser: message.isUser,
//                       message: message.message,
//                       date: DateFormat('HH:mm').format(message.date),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 15,
//                       child: TextFormField(
//                         style: const TextStyle(color: Colors.black),
//                         controller: _userInput,
//                         decoration: InputDecoration(
//                           focusColor: Colors.black,
//                           fillColor: Colors.black,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(
//                                 color: Colors.black, style: BorderStyle.solid),
//                           ),
//                           labelText: 'Ask Anything',
//                         ),
//                       ),
//                     ),
//                     Spacer(),
//                     IconButton(
//                       padding: EdgeInsets.all(12),
//                       iconSize: 30,
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.black),
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                           shape: MaterialStateProperty.all(CircleBorder())),
//                       onPressed: () {
//                         sendMessage();
//                       },
//                       icon: Icon(Icons.send),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }