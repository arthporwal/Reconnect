import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reconnect/pages/comments.dart';

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('posts').snapshots();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: dataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Unable to load posts.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                semanticsLabel: "loading...",
              ),
            );
          }

          final posts = [...?snapshot.data?.docs];
          posts.sort((a, b) {
            final aData = a.data() as Map<String, dynamic>;
            final bData = b.data() as Map<String, dynamic>;
            final aTime = aData['timestamp'];
            final bTime = bData['timestamp'];

            if (aTime is Timestamp && bTime is Timestamp) {
              return bTime.compareTo(aTime);
            }
            if (aTime is Timestamp) return -1;
            if (bTime is Timestamp) return 1;
            return 0;
          });

          if (posts.isEmpty) {
            return const Center(
              child: Text('No posts yet. Share the first thought.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: posts.length,
            itemBuilder: (context, i) {
              final post = posts[i];
              final data = post.data() as Map<String, dynamic>;
              final text = data['text']?.toString() ?? '';

              return Container(
                padding: const EdgeInsets.all(20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 161, 161, 161),
                      Color.fromARGB(121, 253, 255, 250),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Anonymous',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 5, 152, 172),
                            fontSize: 18)),
                    const Divider(
                      thickness: 1,
                      height: 20,
                      color: Color.fromARGB(255, 40, 34, 34),
                    ),
                    Text(text, style: const TextStyle(fontSize: 18)),
                    const Divider(
                      thickness: 1,
                      height: 20,
                      color: Color.fromARGB(255, 40, 34, 34),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Comments(postId: post.id)),
                            );
                          },
                          icon: const Icon(
                            Icons.chat_bubble_outline_rounded,
                          )),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
