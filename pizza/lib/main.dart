import 'package:flutter/material.dart';
import 'screens/master_screen.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'models/user_model.dart';
import 'models/favorite_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => FavoriteModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pizza',
      home: MasterScreen(),
    );
  }
}
