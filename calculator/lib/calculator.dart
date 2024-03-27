import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _counter = 0;
  int _increment = 2;
  int _result = 0;

  // Fonction pour incrémenter le compteur
  void _incrementCounter() {
    setState(() {
      _counter += _increment;
      _result = _counter + _increment;
    });
  }

  // Afficher une alerte si la valeur est <= 0
  void _showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attention'),
          content: const Text(
              'La valeur ne peut pas être 0. La valeur a été réglée à 1.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Construction de l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Champ de texte pour l'incrément
            TextField(
              decoration: const InputDecoration(
                labelText: 'Valeur de l\'incrément',
                border: OutlineInputBorder(),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                final int? newValue = int.tryParse(value);
                if (newValue != null && newValue <= 0) {
                  _showAlert();
                  _increment = 1;
                } else if (newValue != null) {
                  _increment = newValue;
                }
                setState(() {});
              },
            ),
            // Affichage du calcul
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$_counter + $_increment =',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '$_result',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ],
        ),
      ),
      // Bouton flottant pour incrémenter
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrémenter',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.add),
            Text('$_increment'),
          ],
        ),
      ),
    );
  }
}
