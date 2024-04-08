import 'package:flutter/material.dart';
import 'bart.dart';
import 'message.dart';

class Homer extends StatefulWidget {
  const Homer({super.key});

  @override
  HomerState createState() => HomerState();
}

class HomerState extends State<Homer> {
  final TextEditingController _controller = TextEditingController();
  String _messageToBart = '';
  String _messageFromBart = '';

  void _sendMessageToBart() {
    setState(() {
      _messageToBart = _controller.text;
    });
  }

  void _receiveMessageFromBart(String message) {
    setState(() {
      _messageFromBart = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            children: [
              Message(
                text: _messageFromBart.isEmpty
                    ? ''
                    : 'Bart dit à Homer: "$_messageFromBart"',
              ),
              Image.asset('images/Homer.png'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Dites quelque chose à Bart...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _sendMessageToBart,
                child: const Text('Envoyer un message à Bart'),
              ),
            ],
          ),
        ),
        Expanded(
          child: Bart(
            message: _messageToBart,
            onMessageSent: _receiveMessageFromBart,
          ),
        ),
      ],
    );
  }
}
