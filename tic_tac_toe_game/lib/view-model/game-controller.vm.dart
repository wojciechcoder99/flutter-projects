import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/constants.dart';
import 'package:get/get.dart';

import '../model/player.model.dart';
import 'ai-controller.vm.dart';

class GameController extends GetxController {
  static final int boardSize = 10;
  static final double boxSize = 5;
  String previousMove = Player.playerNone;

  List<RxList<RxString>> board;

  var results =
      {Player.playerO: 0, Player.playerX: 0, Constants.DRAW_LABEL: 0}.obs;
  var moves = {Constants.NEXT_MOVE: 'Player\'s X move'}.obs;

  final bool isMultiplayer;
  AIController aiController;

  GameController(this.isMultiplayer) {
    if (!isMultiplayer) {
      aiController = Get.put(AIController(new Random()));
    }
  }

  void initEmptyFields() {
    board = List.generate(
        boardSize,
        (_) =>
            RxList.generate(boardSize, (_) => RxString(Player.playerNone))).obs;
  }

  void clearBoard() {
    for (int i = 0; i < boardSize; i++) {
      for (int i = 0; i < boardSize; i++) {
        board[i][i] = RxString(Player.playerNone);
      }
    }
  }

// ignore: missing_return
  String setCurrentMovePlayer() {
    return _calcCurrentMove();
  }

  // ignore: missing_return
  void setCurrentMoveText() {
    String nM = _calcCurrentMove();
    switch (nM) {
      case Player.ai:
        moves[Constants.NEXT_MOVE] = 'AI\'s move';
        break;
      case Player.playerX:
        moves[Constants.NEXT_MOVE] = 'Player\'s $nM move';
        break;
      case Player.playerO:
        moves[Constants.NEXT_MOVE] = 'Player\'s $nM move';
        break;
    }
    update();
  }

  String _calcCurrentMove() {
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
    if (isMultiplayer) {
      return _selectField(boxValue, rowIndex, fieldIndex);
    } else {
      String result = _selectField(boxValue, rowIndex, fieldIndex);
      if (result != null) return result;
      NextMove values = aiController.nextMove();
      return _selectField(Player.playerNone, values.row, values.field);
    }
  }

  _selectField(String boxValue, int rowIndex, int fieldIndex) {
    if (boxValue == Player.playerNone) {
      String currentMove = _calcCurrentMove();

      updateBoardAndMove(currentMove, rowIndex, fieldIndex);
      setCurrentMoveText();
      String winner = isWinner(rowIndex, fieldIndex, boardSize).value;
      if (winner != Player.playerNone) {
        print(winner);
        results[currentMove] = results[currentMove] + 1;
        previousMove = Player.playerNone;
        update();
        return winner;
      } else if (isEnd()) {
        results[Constants.DRAW_LABEL] = results[Constants.DRAW_LABEL] + 1;
        previousMove = Player.playerNone;
        update();
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

  RxString isWinner(int rowIndex, int fieldIndex, int boardSize) {
    int lengthToWin = 5;

    for (int top = 0; top <= board.length - lengthToWin; ++top) {
      int bottom = top + lengthToWin - 1;

      for (int left = 0; left <= board.length - lengthToWin; ++left) {
        int right = left + lengthToWin - 1;

        // Check each row.
        nextRow:
        for (int row = top; row <= bottom; ++row) {
          if (board[row][left] == Player.playerNone) {
            continue;
          }

          for (int col = left; col <= right; ++col) {
            if (board[row][col] != board[row][left]) {
              continue nextRow;
            }
          }
          return board[row][left];
        }

        // Check each column.
        nextCol:
        for (int col = left; col <= right; ++col) {
          if (board[top][col] == Player.playerNone) {
            continue;
          }

          for (int row = top; row <= bottom; ++row) {
            if (board[row][col] != board[top][col]) {
              continue nextCol;
            }
          }

          return board[top][col];
        }

        // Check top-left to bottom-right diagonal.
        diag1:
        if (board[top][left] != Player.playerNone) {
          for (int i = 1; i < lengthToWin; ++i) {
            if (board[top + i][left + i] != board[top][left]) {
              break diag1;
            }
          }

          return board[top][left];
        }

        // Check top-right to bottom-left diagonal.
        diag2:
        if (board[top][right] != Player.playerNone) {
          for (int i = 1; i < lengthToWin; ++i) {
            if (board[top + i][right - i] != board[top][right]) {
              break diag2;
            }
          }
          return board[top][right];
        }
      }
    }
    return RxString(Player.playerNone);
  }

  List<Widget> boxBuilder<M>(
      List<M> models, Widget Function(int index, M model) builder) {
    return models
        .asMap()
        .map<int, Widget>(
            (index, model) => MapEntry(index, builder(index, model)))
        .values
        .toList();
  }
}
