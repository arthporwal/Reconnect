import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/message.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key, required String title}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  DialogFlowtter? dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    dialogFlowtter = DialogFlowtter(jsonPath: 'assets/dialog_flow_auth.json');
  }

  @override
  void dispose() {
    dialogFlowtter?.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 58, 116, 98),
        title: const Text('Reconnect'),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
              child: MessagesScreen(
            messages: messages,
            controller: _scrollController,
          )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: const Color.fromARGB(255, 43, 165, 139),
            child: SafeArea(
              top: false,
              child: Row(children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Type a Message...',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    autofocus: true,
                    cursorColor: Colors.white,
                    controller: _controller,
                    minLines: 1,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                    color: Colors.white,
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: const Icon(Icons.send))
              ]),
            ),
          )
        ],
      )),
    );
  }

  sendMessage(String text) async {
    final messageText = text.trim();
    if (messageText.isEmpty) {
      print('Message is Empty');
      Fluttertoast.showToast(msg: 'Message is Empty');
    } else {
      setState(() {
        addMessage(messageText, true);
      });
      _scrollToBottom();

      try {
        final response = await dialogFlowtter?.detectIntent(
            queryInput: QueryInput(text: TextInput(text: messageText)));
        final reply = response?.message?.text?.text?.join('\n').trim();
        if (reply == null || reply.isEmpty) {
          Fluttertoast.showToast(msg: 'No reply received');
          return;
        }
        setState(() {
          addMessage(reply);
        });
        _scrollToBottom();
      } catch (error) {
        Fluttertoast.showToast(msg: 'Chatbot reply failed');
        print('Dialogflow error: $error');
      }
    }
  }

  addMessage(String message, [bool isUserMessage = false]) {
    messages.add({'text': message, 'isUserMessage': isUserMessage});
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }
}
