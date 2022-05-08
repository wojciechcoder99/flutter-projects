import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/view-model/constants.dart';
import 'package:get/get.dart';

import '../model/player.model.dart';

class GameController extends GetxController {
  static final int boardSize = 10;
  static final double boxSize = 5;
  String previousMove = Player.playerNone;

  List<RxList<RxString>> board;

  Map<String, int> results = {
    Player.playerO: 0,
    Player.playerX: 0,
    Constants.DRAW_LABEL: 0
  };

  void setEmptyFields() {
    board = List.generate(
        boardSize,
        (_) => RxList.generate(boardSize, (_) => RxString(Player.playerNone))).obs;
  }

// ignore: missing_return
  String setCurrentMovePlayer() {
    return _calcNextMove();
  }

  // ignore: missing_return
  String nextMoveText() {
    String nextMove = _calcNextMove();
    switch (nextMove) {
      case Player.ai:
        return 'AI\'s move';
      case Player.playerX:
        return 'Player\'s $nextMove move';
      case Player.playerO:
        return 'Player\'s $nextMove move';
    }
  }

  String _calcNextMove() {
    return previousMove == Player.playerX ? Player.playerO : Player.playerX;
  }

  Color getBackgroundColor() {
    final nextMove =
        previousMove == Player.playerO ? Player.playerX : Player.playerO;
    return getFieldColor(nextMove).withAlpha(150);
  }

  getFieldColor(String boxValue) {
    switch (boxValue) {
      case Player.playerO:
        return Colors.red;
      case Player.playerX:
        return Colors.green;
      default:
        return Colors.grey.withAlpha(500);
    }
  }

  selectField(String boxValue, int rowIndex, int fieldIndex) {
    if (boxValue == Player.playerNone) {
      String currentMove = _calcNextMove();

      updateBoardAndMove(currentMove, rowIndex, fieldIndex);

      if (isWinner(rowIndex, fieldIndex, boardSize)) {
        results[currentMove] = results[currentMove] + 1;
        return currentMove;
      } else if (isEnd()) {
        results[Constants.DRAW_LABEL] = results[Constants.DRAW_LABEL] + 1;
        return Constants.DRAW_LABEL;
      }
    }
  }

  void updateBoardAndMove(String currentMove, int rowIndex, int fieldIndex) {
    previousMove = currentMove;
    board[rowIndex][fieldIndex] = RxString(currentMove);
  }

  bool isEnd() {
    return board
        .every((row) => row.every((field) => field != Player.playerNone));
  }

  bool isWinner(int rowIndex, int fieldIndex, int boardSize) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = board[rowIndex][fieldIndex];
    final n = boardSize - 1;

    for (int i = 0; i < n; i++) {
      if (board[rowIndex][i] == player) col++;
      if (board[i][fieldIndex] == player) row++;
      if (board[i][i] == player) diag++;
      if (board[i][n - i - 1] == player) {
        rdiag++;
      }
    }
    return row == 5 || col == 5 || diag == 5 || rdiag == 5;
  }
}
