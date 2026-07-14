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
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: dataStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {}
                if (snapshot.connectionState == ConnectionState.waiting) {
                  CircularProgressIndicator(
                    color: Colors.black,
                    semanticsLabel: "loading...",
                  );
                }
                final List storedocs = [];
                snapshot.data?.docs.map((DocumentSnapshot document) {
                  Map a = document.data() as Map<String, dynamic>;
                  storedocs.add(a);
                  a['id'] = document.id;
                }).toList();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      storedocs.length,
                      (i) => Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.all(20),
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
                            // color: Color.fromARGB(23, 162, 140, 140),
                            child: Column(
                              children: [
                                Text('User',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 5, 152, 172),
                                        fontSize: 18)),
                                const Divider(
                                  thickness: 1,
                                  height: 20,
                                  color: Color.fromARGB(255, 40, 34, 34),
                                ),

                                //SizedBox(height: 0),
                                Text(storedocs[i]['text'],
                                    style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                //SizedBox(height: 10),
                                const Divider(
                                  thickness: 1,
                                  height: 20,
                                  color: Color.fromARGB(255, 40, 34, 34),
                                ),

                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Comments()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.chat_bubble_outline_rounded,
                                    )),
                                // SizedBox(height: 10),
                              ],
                            ),
                          )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
