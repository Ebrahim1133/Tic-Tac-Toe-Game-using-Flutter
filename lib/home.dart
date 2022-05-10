import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tic_tac_toe/style.dart';

import 'game_logic.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Home> {
  String activePlayer = 'x';
  String result = '';
  int turn = 0;
  bool isSwitched = false;
  bool gameover = false;
  Game game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SwitchListTile.adaptive(
                activeColor: Colors.pinkAccent,
                title: Text(
                  'Turn on/off two player',
                  style: style1,
                ),
                value: isSwitched,
                onChanged: (bool val) {
                  setState(() {
                    isSwitched = val;
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            Text(
              gameover && turn != 9
                  ? "Finish"
                  : " ${activePlayer.toUpperCase()} Turn Now",
              style: style2,
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 3,
                children: List.generate(
                    9,
                    (index) => InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: gameover ? null : () => tap(index),
                          child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#ec7475"),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              Player.playerX.contains(index)
                                  ? "x"
                                  : Player.playerO.contains(index)
                                      ? 'o'
                                      : '',
                              style: TextStyle(
                                  fontSize: 60,
                                  color: Player.playerX.contains(index)
                                      ? Colors.white
                                      : Colors.red),
                            )),
                          ),
                        )),
              ),
            ),
            Text(
              result,
              style: style2,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    Player.playerX.clear();
                    Player.playerO.clear();
                    activePlayer = 'x';
                    result = '';
                    turn = 0;
                    gameover = false;
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text('Repeat the game'))
          ],
        ),
      )),
    );
  }

  tap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      Game.playGame(index, activePlayer);
      updateState();
      if (!isSwitched && !gameover && turn != 9) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    setState(() {
      activePlayer = activePlayer == 'x' ? 'o' : 'x';
      turn++;

      String winnerP = game.checkWinner();
      if (winnerP != '') {
        gameover = true;
        result = "$winnerP is the Winner ";
      } else if (!gameover && turn == 9) {
        result = "it's Draw";
      }
    });
  }
}
