import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  // PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 58, 116, 98),
        leading: IconButton(
          // Icons.arrow_back_ios_new_sharp,
          // color: Colors.black,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Comments',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.white70,
              child: Row(children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.emoji_emotions_outlined),
                        hintText: 'Add a Comment...',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    autofocus: true,
                    cursorColor: Colors.black,
                    // controller: _controller,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                    color: Colors.black,
                    onPressed: () {},
                    icon: const Icon(Icons.send))
              ]),
            ),
          )
        ],
      )),
    );
  }
}
