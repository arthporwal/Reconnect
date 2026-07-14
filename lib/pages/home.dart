import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reconnect/pages/Feed.dart';
import 'package:reconnect/pages/councellors.dart';
import 'package:reconnect/pages/games.dart';
import 'header_drawer.dart';
import 'chatbot.dart';
import 'create_post.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 43, 165, 139),
            elevation: 12,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 58, 116, 98),
                    Color.fromARGB(255, 36, 182, 121)
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
            bottom: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 6,
                tabs: [
                  Tab(icon: Icon(Icons.home), text: 'Home'),
                  Tab(icon: Icon(Icons.draw), text: 'Create'),
                  Tab(icon: Icon(Icons.gamepad), text: 'Games'),
                ]),
            title: const Text('Reconnect'),
            centerTitle: true,
            // leading: IconButton(
            //leading adds to left
            // icon: const Icon(Icons.menu),
            // onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const HeaderDrawer(),
            //     ));
            // },
            // ),
            actions: [
              IconButton(
                icon: const Icon(Icons.emoji_people_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Experts(),
                      ));
                },
              ),
            ],
          ),

          // code for chatbot icon
          floatingActionButton: FloatingActionButton(
            // ignore: sort_child_properties_last
            child: const Icon(Icons.chat),
            backgroundColor: const Color.fromARGB(255, 43, 165, 139),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Send "Hey!" to start a chat');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Chatbot(
                            title: "Chatbot",
                          )));
            },
          ),

          //building pages
          body: TabBarView(
            children: [Feed(id: toString()), CreatePost(), Game_page()],
          ),

          // code for drawer , 2 files linked
          drawer: HeaderDrawer(),
        ),
      );

  // code for content in the pages
  Widget buildPage(String text) => Center(
          child: Text(
        text,
        style: const TextStyle(fontSize: 30),
      ));
}
