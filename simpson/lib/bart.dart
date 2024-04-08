import 'package:flutter/material.dart';
import 'message.dart';

class Bart extends StatelessWidget {
  final String message;
  final Function(String) onMessageSent;

  const Bart({super.key, required this.message, required this.onMessageSent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset('images/Bart.png'),
        Message(
          text: message.isEmpty ? "" : "Homer dit à Bart \" $message \"",
        ),
        ElevatedButton(
          onPressed: () => onMessageSent("Salut Papa"),
          child: const Text('Répondre à Homer'),
        ),
      ],
    );
  }
}
