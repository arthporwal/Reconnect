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
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          // height: 10.0,
          width: double.maxFinite,
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: TextField(
                onChanged: (val) {
                  setState(() {
                    text = val;
                  });
                },
                maxLength: 3000,
                // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLines: 6,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Share your thoughts :)",
                    prefixIcon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ))),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                  backgroundColor: Color.fromARGB(255, 43, 165, 139)),
              onPressed: () async {
                _postService.savePost(text);
                // Navigator.push(
                //     context, MaterialPageRoute(builder: ((context) => Home())));

                Fluttertoast.showToast(msg: 'Sharing...');
              },
              child: Text('Share'),
            )
          ],
        )
      ]),
    );
  }
}
