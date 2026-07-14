import 'package:flutter/material.dart';
import 'package:reconnect/pages/game_details.dart';
import 'package:reconnect/widgets/game_list.dart';

class Game_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: gameList.length,
        itemBuilder: (context, index) {
          Game game = gameList[index];
          return Card(
            child: ListTile(
              title: Text(game.title),
              leading: Image.network(game.imageUrl),
              horizontalTitleGap: 30,
              minVerticalPadding: 30,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GameDetails(game)));
              },
            ),
          );
        },
      ),
    );
  }
}
