import 'dart:ffi';

import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

class Game {
  static void playGame(int index, String activePlayer) {
    if (activePlayer == 'x') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  Future<Void?>? autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyP = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptyP.add(i);
      }
    }
    Random rand = Random();
    int randomIndex = rand.nextInt(emptyP.length);
    index = emptyP[randomIndex];
    playGame(index, activePlayer);
  }

  String checkWinner() {
    String winner = '';
    if (Player.playerX.containall(0, 1, 2) ||
        Player.playerX.containall(3, 4, 5) ||
        Player.playerX.containall(6, 7, 8) ||
        Player.playerX.containall(0, 4, 8) ||
        Player.playerX.containall(2, 4, 7) ||
        Player.playerX.containall(0, 3, 6) ||
        Player.playerX.containall(1, 4, 7) ||
        Player.playerX.containall(2, 5, 8) ||
        Player.playerX.containall(2, 4, 6)) {
      winner = "X";
    } else if ((Player.playerO.containall(0, 1, 2) ||
        Player.playerO.containall(3, 4, 5) ||
        Player.playerO.containall(6, 7, 8) ||
        Player.playerO.containall(0, 4, 8) ||
        Player.playerO.containall(2, 4, 7) ||
        Player.playerO.containall(0, 3, 6) ||
        Player.playerO.containall(1, 4, 7) ||
        Player.playerO.containall(2, 5, 8) ||
        Player.playerO.containall(2, 4, 6))) {
      winner = "O";
    } else {
      winner = "";
    }
    return winner;
  }
}

extension Containall on List {
  bool containall(int x, int y, int z) {
    return contains(x) && contains(y) && contains(z);
  }
}
