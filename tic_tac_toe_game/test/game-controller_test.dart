import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/model/player.model.dart';
import 'package:flutter_complete_guide/utils/constants.dart';
import 'package:flutter_complete_guide/view-model/game-controller.vm.dart';
import 'package:get/get.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  int boardSize = 10;

  test('Board should be initialized with empty fields', () {
    // given
    GameController gameController = Get.put(GameController(true));
    List<RxList<RxString>> board = List.generate(boardSize,
        (_) => RxList.generate(boardSize, (_) => RxString(Player.playerNone)));

    // when
    gameController.initEmptyFields();

    // then
    expect(gameController.board, board);
    expect(gameController.board.length, board.length);
    for (int i = 0; i < boardSize; i++) {
      expect(gameController.board[i].length, board[i].length);
    }

    Get.delete<GameController>();
  });

  test('Should be multiplayer mode', () {
    // given, when
    GameController gameController = Get.put(GameController(true));

    // then
    expect(gameController.isMultiplayer, true);
    Get.delete<GameController>();
  });

  test('Board should be cleared', () {
    // given
    GameController gameController = Get.put(GameController(true));
    gameController.initEmptyFields();
    for (int i = 0; i < boardSize; i++) {
      for (int i = 0; i < boardSize; i++) {
        gameController.board[i][i] = RxString(Player.playerO);
      }
    }
    List<RxList<RxString>> board = List.generate(boardSize,
        (_) => RxList.generate(boardSize, (_) => RxString(Player.playerNone)));

    // when
    gameController.clearBoard();

    // then
    expect(gameController.board, board);
    Get.delete<GameController>();
  });

  test('Current should be player X move', () {
    // given
    GameController gameController = Get.put(GameController(true));
    gameController.previousMove = Player.playerO;
    // when
    String currentMove = gameController.setCurrentMovePlayer();

    // then
    expect(currentMove, Player.playerX);
    Get.delete<GameController>();
  });

  test('Next should be player O move', () {
    // given
    GameController gameController = Get.put(GameController(true));
    gameController.previousMove = Player.playerX;

    // when
    gameController.setCurrentMoveText();

    // then
    expect(gameController.moves[Constants.NEXT_MOVE], 'Player\'s O move');
    Get.delete<GameController>();
  });

  test('Background color should be red', () {
    // given
    GameController gameController = Get.put(GameController(true));
    gameController.previousMove = Player.playerX;

    // when
    Color actualColor = gameController.getBackgroundColor();

    // then
    expect(actualColor, Colors.red.withAlpha(150));
    Get.delete<GameController>();
  });

  test('Field color should be green', () {
    // given
    GameController gameController = Get.put(GameController(true));

    // when
    Color actualColor = gameController.getFieldColor(Player.playerX);

    // then
    expect(actualColor, Colors.green);
    Get.delete<GameController>();
  });

  test('Should make a correct move', () {
    // given
    GameController gameController = Get.put(GameController(true));
    gameController.initEmptyFields();

    // when
    String actualMove = gameController.selectField(Player.playerX, 5, 3);

    // then
    expect(actualMove, null);
    Get.delete<GameController>();
  });

  test('Should player X win', () {
    // given
    String winner;
    Get.delete<GameController>();
    GameController gameController = Get.put(GameController(true));
    gameController.initEmptyFields();

    // when
    for (int i = 0; i < 5; i++) {
      winner = gameController.selectField(Player.playerNone, 0, i);
      gameController.previousMove = Player.playerO;
    }

    // then
    expect(winner, Player.playerX);
    Get.delete<GameController>();
  });

  test(
      'Should be board[2][2] filled with Player X and previous move set to Player O',
      () {
    // given
    GameController gameController = Get.put(GameController(true));
    gameController.initEmptyFields();

    // when
    gameController.updateBoardAndMove(Player.playerX, 2, 2);

    // then
    expect(gameController.previousMove, Player.playerX);
    expect(gameController.board[2][2].value, Player.playerX);
  });
}
