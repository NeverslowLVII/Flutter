import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CustomPizzaScreen extends StatefulWidget {
  const CustomPizzaScreen({super.key});
  @override
  CustomPizzaScreenState createState() => CustomPizzaScreenState();
}

class CustomPizzaScreenState extends State<CustomPizzaScreen> {
  final List<String> _selectedIngredients = [];
  final List<String> _availableIngredients = [
    'Ail',
    'Anchois',
    'Aubergines',
    'Basilic',
    'Champignons',
    'Chèvre',
    'Coeur d\'artichaut',
    'Courgettes',
    'Fromage',
    'Gorgonzola',
    'Jambon',
    'Jambon cru',
    'Jambon cuit',
    'Mozzarella',
    'Olives noires',
    'Olives vertes',
    'Oignons',
    'Origan',
    'Parmesan',
    'Pepperoni',
    'Poivrons',
    'Provola',
    'Roquette',
    'Saucisson piquant',
    'Saumon',
    'Tomate',
  ];
  String _selectedBase = 'Tomate';
  final List<String> _availableBases = ['Tomate', 'Crème', 'Nature'];

  void _addOrRemoveIngredient(String ingredient) {
    setState(() {
      if (_selectedIngredients.contains(ingredient)) {
        _selectedIngredients.remove(ingredient);
      } else if (_selectedIngredients.length < 5) {
        _selectedIngredients.add(ingredient);
      }
    });
  }

  void _changeBase(String? base) {
    if (base != null) {
      setState(() {
        _selectedBase = base;
      });
    }
  }

  void _addToCart() {
    if (_selectedIngredients.isNotEmpty) {
      Provider.of<CartModel>(context, listen: false).addItem({
        'name': 'Pizza Personnalisée',
        'price': 14.0,
        'base': _selectedBase,
        'ingredients': _selectedIngredients,
        'quantity': 1
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créer une Pizza Personnalisée')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Base'),
            DropdownButton<String>(
              value: _selectedBase,
              items: _availableBases
                  .map((base) =>
                      DropdownMenuItem(value: base, child: Text(base)))
                  .toList(),
              onChanged: _changeBase,
              isExpanded: true,
              underline: Container(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _availableIngredients
                    .map((ingredient) => ChoiceChip(
                          label: Text(ingredient),
                          selected: _selectedIngredients.contains(ingredient),
                          onSelected: (_) => _addOrRemoveIngredient(ingredient),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _addToCart,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.5)),
                  padding: const EdgeInsets.all(24.0),
                ),
                child: const Text('Ajouter au Panier'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
