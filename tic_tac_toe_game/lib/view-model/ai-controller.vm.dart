import 'package:get/get.dart';

class NextMove {
  final int row;
  final int field;

  NextMove(this.row, this.field);

  int getRow() {
    return this.row;
  }

  int getField() {
    return this.field;
  }
}

class AIController extends GetxController{
  final random;
  AIController(this.random);

  NextMove nextMove() {
    return NextMove(random.nextInt(10), random.nextInt(10));
  }
}
