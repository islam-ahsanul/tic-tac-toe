import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // canvasColor: Color.fromARGB(255, 110, 255, 255),
        canvasColor: Colors.red[600],
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tiles = List.filled(9, 0);
  void refresh() {
    tiles = List.filled(9, 0);
    var intValue = Random().nextInt(2);
    if (intValue == 1) {
      runAi();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          shadowColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text('Tic Tac Toe'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GridView.count(
                  padding: EdgeInsets.all(15),
                  crossAxisCount: 3,
                  children: [
                    for (var i = 0; i < 9; i++)
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                        margin: EdgeInsets.all(1),
                        child: InkWell(
                          onTap: () {
                            if (isWinning(1, tiles)) {
                              return;
                            } else if (isWinning(2, tiles)) {
                              return;
                            } else {
                              setState(() {
                                if (tiles[i] == 0) {
                                  tiles[i] = 1;
                                  runAi();
                                }
                              });
                            }
                          },
                          child: Center(
                            child: Text(
                              tiles[i] == 0
                                  ? ''
                                  : tiles[i] == 1
                                      ? '✖️'
                                      : '⭕',
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 15,
                      side: BorderSide(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        refresh();
                      });
                    },
                    child: Text(
                      'Restart',
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        isWinning(1, tiles)
                            ? 'You Won!'
                            : isWinning(2, tiles)
                                ? 'You Lost!'
                                : 'Your move',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void runAi() async {
    await Future.delayed(Duration(milliseconds: 200));

    int? winning;
    int? blocking;
    int? normal;

    for (var i = 0; i < 9; i++) {
      var val = tiles[i];
      if (val > 0) {
        continue;
      }
      var future = [...tiles]..[i] = 2;
      if (isWinning(2, future)) {
        winning = i;
      }
      if (isWinning(1, future)) {
        blocking = 1;
      }
      normal = i;
    }

    var move = winning ?? blocking ?? normal;

    if (move != null) {
      setState(() {
        tiles[move] = 2;
      });
    }
  }

  bool isWinning(int who, List<int> tiles) {
    return (tiles[0] == who && tiles[1] == who && tiles[2] == who) ||
        (tiles[3] == who && tiles[4] == who && tiles[5] == who) ||
        (tiles[6] == who && tiles[7] == who && tiles[8] == who) ||
        (tiles[0] == who && tiles[4] == who && tiles[8] == who) ||
        (tiles[2] == who && tiles[4] == who && tiles[6] == who) ||
        (tiles[0] == who && tiles[3] == who && tiles[6] == who) ||
        (tiles[1] == who && tiles[4] == who && tiles[7] == who) ||
        (tiles[2] == who && tiles[5] == who && tiles[8] == who);
  }
}
