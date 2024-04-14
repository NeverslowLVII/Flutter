import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import 'details_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  return ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      var item = cart.items[index];
                      return ListTile(
                        leading: Image.network(
                            'https://pizzas.shrp.dev/assets/${item['image']}'),
                        title: Text(item['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Base: ${item['base']}\nIngrédients: ${item['ingredients'].join(', ')}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<int>(
                                  value: item['quantity'],
                                  items: [
                                    const DropdownMenuItem(
                                        value: -1, child: Text("Supprimer")),
                                    for (var i = 1; i <= 10; i++)
                                      DropdownMenuItem(
                                          value: i, child: Text("$i")),
                                  ],
                                  onChanged: (value) {
                                    if (value == -1) {
                                      cart.removeItem(item);
                                    } else {
                                      setState(() {
                                        item['quantity'] = value;
                                      });
                                    }
                                  },
                                  underline: Container(),
                                ),
                                Text('${item['price'] * item['quantity']} €',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(pizzaDetails: item),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sous-total:',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${cart.totalPrice} €',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.5)),
                padding: const EdgeInsets.all(24.0),
              ),
              child: const Text('Commander'),
            ),
          ],
        ),
      ),
    );
  }
}
