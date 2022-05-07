import 'package:flutter/material.dart';

class Utils {
  static List<Widget> boxBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  static bool isWinner(
      int rowIndex, int fieldIndex, List<List<String>> board, int boardSize) {
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
