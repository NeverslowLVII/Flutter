import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static const String title = 'Bandit Manchot';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: const Center(child: SlotMachine()),
      ),
    );
  }
}

class SlotMachine extends StatefulWidget {
  const SlotMachine({super.key});

  @override
  SlotMachineState createState() => SlotMachineState();
}

class SlotMachineState extends State<SlotMachine> {
  static const List<String> imgList = [
    'images/casino-chip.png',
    'images/cherry.png',
    'images/clover.png',
    'images/diamond.png',
    'images/joker.png',
    'images/seven.png',
    'images/spade.png'
  ];

  List<String> result;
  String message = '';
  final Random random = Random();
  bool isButtonDisabled = false;

  SlotMachineState()
      : result =
            List.generate(3, (_) => imgList[Random().nextInt(imgList.length)]);

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      result = List.generate(3, (_) => imgList[random.nextInt(imgList.length)]);
      message = '';
      isButtonDisabled = false;
    });
  }

  void play() {
    setState(() {
      isButtonDisabled = true;
      result = List.generate(3, (_) => imgList[random.nextInt(imgList.length)]);
      message = checkResult();
      isButtonDisabled = false;
    });
  }

  String checkResult() {
    if (result.toSet().length == 1) {
      return result[0] == 'images/seven.png'
          ? 'Special Jackpot with 7!'
          : 'Jackpot';
    }
    return 'You lost, try again!';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: result
              .map((img) => Image.asset(img, width: 100, height: 100))
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message, style: const TextStyle(fontSize: 20)),
        ),
        FloatingActionButton(
          onPressed: isButtonDisabled ? null : play,
          backgroundColor: isButtonDisabled ? Colors.grey : null,
          child: const Icon(Icons.casino),
        ),
      ],
    );
  }
}
