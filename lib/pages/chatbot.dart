import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/message.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key, required String title}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];

  @override
  void dispose() {
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
        await Future<void>.delayed(const Duration(milliseconds: 300));
        final reply = _localReply(messageText);
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

  String _localReply(String message) {
    final text = message.toLowerCase();
    if (text.contains('suicide') ||
        text.contains('self harm') ||
        text.contains('kill myself') ||
        text.contains('emergency')) {
      return 'I’m really glad you reached out. If you might hurt yourself or are in immediate danger, please contact your local emergency services now, or ask someone you trust to stay with you. You deserve immediate, in-person support.';
    }
    if (text.contains('anxious') || text.contains('anxiety') || text.contains('panic')) {
      return 'That sounds difficult. Try slowing your breathing: inhale for four counts, hold for four, and exhale for six. If these feelings keep returning, consider sharing them with someone you trust or a mental-health professional.';
    }
    if (text.contains('sad') || text.contains('lonely') || text.contains('depress')) {
      return 'I’m sorry you’re carrying that. You do not have to handle it alone. A small next step—messaging someone you trust, drinking some water, or taking a short break—can be enough for this moment.';
    }
    if (text.contains('stress') || text.contains('overwhelm')) {
      return 'It makes sense to feel overwhelmed when a lot is happening. Pick one small thing you can do in the next few minutes, and give yourself permission to pause the rest for now.';
    }
    return 'Thank you for sharing. I’m here to listen. What feels most important for you to talk about right now?';
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
