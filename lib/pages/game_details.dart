import 'package:flutter/material.dart';
import 'package:reconnect/widgets/game_list.dart';
import 'package:url_launcher/link.dart';

class GameDetails extends StatelessWidget {
  final Game game;

  GameDetails(this.game);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        backgroundColor: Color.fromARGB(255, 58, 116, 98),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 50),
              Image.network(game.imageUrl),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Link(
                      uri: Uri.parse(game.link),
                      builder: (context, followLink) {
                        return ElevatedButton(
                          onPressed: followLink,
                          child: Text('Download'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 36, 182, 121),
                            fixedSize: Size.fromWidth(290),
                          ),
                        );
                      }),
                ],
              ),
              //   SizedBox(height: 50),
              //   Padding(
              //     padding: EdgeInsets.all(10),
              //     // child: Text(
              //     //   game.discription,
              //     //   textAlign: TextAlign.center,
              //     // ),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
