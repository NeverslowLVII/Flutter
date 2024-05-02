import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'signin_screen.dart';
import 'pizza_screen.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});
  @override
  MasterScreenState createState() => MasterScreenState();
}

class MasterScreenState extends State<MasterScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions(UserModel userModel) => <Widget>[
        const PizzaScreen(),
        const CartScreen(),
        if (userModel.isLoggedIn)
          UserProfileScreen(userData: userModel.userData),
        if (!userModel.isLoggedIn) const SignInScreen(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    List<Widget> widgetOptions = _widgetOptions(userModel);

    List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Accueil',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Panier',
      ),
    ];

    if (userModel.isLoggedIn) {
      navItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profil',
      ));
    } else {
      navItems.addAll([
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Connexion',
        ),
      ]);
    }

    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        onTap: _onItemTapped,
      ),
    );
  }
}
