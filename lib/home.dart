// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game_/foodGrid.dart';
import 'package:snake_game_/gridGame.dart';
import 'package:snake_game_/snakeGrid.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

enum snake_Direction { UP, DOWN, LEFT, RIGHT }

class _homeState extends State<home> {
  var currentDirection = snake_Direction.RIGHT;

  int score = 0;
  int itemNumber = 100;
  int rowSize = 10;
  int food = 50;

  List<int> snake = [
    0,
    1,
    2,
  ];
  void eatfood() {
    while (snake.contains(food)) {
      food = Random().nextInt(itemNumber);
    }
  }

  void startGame() {
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        move();
        eatfood();
        if (gameOver()) {
          timer.cancel();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Game over"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade100,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text("Cancel"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.deepPurple.shade100,
                              ),
                              child: Text("ok"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }

  bool gameOver() {
    List<int> bodySnake = snake.sublist(0, snake.length - 1);
    if (bodySnake.contains(snake.last)) {
      return true;
    }
    return false;
  }

  void move() {
    switch (currentDirection) {
      case snake_Direction.RIGHT:
        if (snake.last % rowSize == 9) {
          snake.add(snake.last + 1 - rowSize);
        } else {
          snake.add(snake.last + 1);
        }
        break;
      case snake_Direction.LEFT:
        if (snake.last % rowSize == 0) {
          snake.add(snake.last - 1 + rowSize);
        } else {
          snake.add(snake.last - 1);
        }
        break;
      case snake_Direction.UP:
        if (snake.last < rowSize) {
          snake.add(snake.last - rowSize + itemNumber);
        } else {
          snake.add(snake.last - rowSize);
        }
        break;
      case snake_Direction.DOWN:
        if (snake.last + rowSize > itemNumber) {
          snake.add(snake.last + rowSize - itemNumber);
        } else {
          snake.add(snake.last + rowSize);
        }
        break;
      default:
    }
    if (food == snake.last) {
      eatfood;
    } else {
      snake.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Snake Game",
                      style: TextStyle(
                        fontSize: 38,
                        color: Colors.deepPurple.shade100,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0 &&
                      currentDirection != snake_Direction.UP) {
                    currentDirection = snake_Direction.DOWN;
                    print("move down");
                  } else if (details.delta.dy < 0 &&
                      currentDirection != snake_Direction.DOWN) {
                    currentDirection = snake_Direction.UP;

                    print("move up");
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0 &&
                      currentDirection != snake_Direction.LEFT) {
                    currentDirection = snake_Direction.RIGHT;

                    print("move right");
                  } else if (details.delta.dx < 0 &&
                      currentDirection != snake_Direction.RIGHT) {
                    currentDirection = snake_Direction.LEFT;

                    print("move left");
                  }
                },
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemNumber,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowSize),
                  itemBuilder: (context, index) {
                    if (snake.contains(index)) {
                      return snakeGrid();
                    } else if (index == food) {
                      return foodGrid();
                    } else {
                      return gridGame();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: MaterialButton(
                    color: Colors.teal,
                    child: Text('Play'),
                    onPressed: startGame,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
