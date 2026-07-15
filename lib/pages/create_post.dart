import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/firestore.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final PostService _postService = PostService();
  final TextEditingController _controller = TextEditingController();
  String text = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          TextField(
              controller: _controller,
              onChanged: (val) {
                setState(() {
                  text = val;
                });
              },
              maxLength: 3000,
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Share your thoughts :)",
                  prefixIcon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ))),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  backgroundColor: const Color.fromARGB(255, 43, 165, 139)),
              onPressed: () async {
                final postText = text.trim();
                if (postText.isEmpty) {
                  Fluttertoast.showToast(msg: 'Write something first');
                  return;
                }

                await _postService.savePost(postText);
                _controller.clear();
                setState(() {
                  text = '';
                });
                Fluttertoast.showToast(msg: 'Shared');
              },
              child: const Text('Share'),
            ),
          )
        ],
      ),
    );
  }
}
