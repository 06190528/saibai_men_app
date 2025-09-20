import 'dart:math';
import 'package:flame/components.dart';

enum Direction { up, down, left, right, none }

Vector2 detectDirection(Direction direction, double deltaPosition) {
  // 次の位置を計算します
  switch (direction) {
    case Direction.up:
      return Vector2(0, -deltaPosition);
    case Direction.down:
      return Vector2(0, deltaPosition);
    case Direction.left:
      return Vector2(-deltaPosition, 0);
    case Direction.right:
      return Vector2(deltaPosition, 0);
    case Direction.none:
      return Vector2.zero();
  }
}

bool canGo(
    Vector2 nextPosition, Vector2 screenSize, Vector2 size, String name) {
  // 直接条件を評価して結果を返す
  if (name == 'enemy') {
    return nextPosition.x >= 0 &&
        nextPosition.x <= screenSize.x &&
        nextPosition.y >= 0 &&
        nextPosition.y <= screenSize.y;
  }
  return nextPosition.x >= 0 &&
      nextPosition.x <= screenSize.x &&
      nextPosition.y >= 0 &&
      nextPosition.y <= screenSize.y - 50; //バナーの大きさ分小さくする
}

Vector2 initialPosition(Vector2 worldSize, String name) {
  var rng = Random();
  int directionNum = rng.nextInt(4); // Four directions
  double randomX = 0;
  double randomY = 0;

  if (name == 'deathblow') {
    randomX = rng.nextDouble() * worldSize.x;
    randomY = 0; //バナーの大きさ分小さくする
    return Vector2(randomX, randomY);
  }
  switch (directionNum) {
    case 0: // Down
      randomX = rng.nextDouble() * worldSize.x;
      randomY = 0;
      break;
    case 1: // Up
      randomX = rng.nextDouble() * worldSize.x;
      randomY = worldSize.y; //バナーの大きさ分小さくする
      break;
    case 2: // Right
      randomX = 0; // Left of the screen
      randomY = rng.nextDouble() * worldSize.y;
      break;
    case 3: // Left
      randomX = worldSize.x; // Right of the screen
      randomY = rng.nextDouble() * worldSize.y; //バナーの大きさ分小さくする
      break;
  }

  return Vector2(randomX, randomY);
}

Direction enemyInitialDirection(Vector2 position, Vector2 worldSize) {
  Direction direction = Direction.none;
  if (position.x == 0) {
    direction = Direction.right;
  } else if (position.x == worldSize.x) {
    direction = Direction.left;
  } else if (position.y == 0) {
    direction = Direction.down;
  } else if (position.y == worldSize.y) {
    direction = Direction.up;
  }
  return direction;
}
