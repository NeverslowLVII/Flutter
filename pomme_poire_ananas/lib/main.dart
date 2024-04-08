import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<int> _counterValues = [];

  void _incrementCounter() {
    setState(() {
      _counterValues.add(_counterValues.length + 1);
    });
  }

  bool isPrime(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number / i; ++i) {
      if (number % i == 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String titleText;
    if (isPrime(_counterValues.length)) {
      titleText = '${_counterValues.length} Nombre premier';
    } else if (_counterValues.length % 2 == 0) {
      titleText = '${_counterValues.length} Nombre paire';
    } else {
      titleText = '${_counterValues.length} Nombre impaire';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(titleText),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _counterValues.length,
          itemBuilder: (context, index) {
            String imagePath;
            if (isPrime(_counterValues[index])) {
              imagePath = 'images/ananas.png';
            } else if (_counterValues[index] % 2 == 0) {
              imagePath = 'images/poire.png';
            } else {
              imagePath = 'images/pomme.png';
            }
            return Container(
              color:
                  _counterValues[index] % 2 == 0 ? Colors.indigo : Colors.cyan,
              child: ListTile(
                leading: Image.asset(imagePath),
                title: Text(
                  '${_counterValues[index]}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: _counterValues.isEmpty
            ? Colors.orange
            : (_counterValues.last % 2 == 0 ? Colors.indigo : Colors.cyan),
        child: const Icon(Icons.add),
      ),
    );
  }
}
