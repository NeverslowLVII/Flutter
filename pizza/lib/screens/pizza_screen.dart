import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import 'package:provider/provider.dart';
import 'details_screen.dart';
import '../services/api_service.dart';
import '../models/favorite_model.dart';
import 'custom_pizza_screen.dart';

class PizzaScreen extends StatefulWidget {
  const PizzaScreen({super.key});
  @override
  PizzaScreenState createState() => PizzaScreenState();
}

class PizzaScreenState extends State<PizzaScreen> {
  late Future<List<dynamic>> _pizzaList;
  String sortType = 'base';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSortedPizzas();
  }

  void _fetchSortedPizzas() {
    _pizzaList = ApiService().fetchPizzasList().then((list) {
      return _sortPizzas(list, sortType);
    });
  }

  List<dynamic> _sortPizzas(List<dynamic> pizzas, String sortType) {
    if (sortType == 'base') {
      pizzas.sort((a, b) => a['base'].compareTo(b['base']));
    } else if (sortType == 'category') {
      pizzas.sort((a, b) => a['category'].compareTo(b['category']));
    }
    return pizzas;
  }

  void _changeSortType(String newSortType) {
    setState(() {
      sortType = newSortType;
      _fetchSortedPizzas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pizzas'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: _changeSortType,
              itemBuilder: (BuildContext context) {
                return {'base', 'category'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text('Trier par $choice'),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Rechercher une pizza',
                  suffixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomPizzaScreen()),
                  );
                },
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
                child: const Text('Créer une pizza personnalisée'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FutureBuilder<List<dynamic>>(
                  future: _pizzaList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var filteredList = snapshot.data!.where((item) {
                        return item['name']
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase());
                      }).toList();
                      return ListView.separated(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          var item = filteredList[index];
                          var cartItems = Provider.of<CartModel>(context).items;
                          var foundItem = cartItems.firstWhere(
                              (i) => i['id'] == item['id'],
                              orElse: () => null);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(pizzaDetails: item),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          item['name'],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text('${item['price']} €',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            'Ingrédients: ${item['ingredients'].join(', ')}',
                                            style:
                                                const TextStyle(fontSize: 14)),
                                        Text(
                                          'Base: ${item['base']}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          'Catégorie: ${item['category']}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          'https://pizzas.shrp.dev/assets/${item['image']}',
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: foundItem != null
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  '${foundItem['quantity']}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            icon: const Icon(Icons.add,
                                                size: 24, color: Colors.black),
                                            onPressed: () {
                                              Provider.of<CartModel>(context,
                                                      listen: false)
                                                  .addItem(item);
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Ajouté au panier !')),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        bottom: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Provider.of<FavoriteModel>(
                                                          context)
                                                      .isFavorite(item)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              var favoriteModel =
                                                  Provider.of<FavoriteModel>(
                                                      context,
                                                      listen: false);
                                              if (favoriteModel
                                                  .isFavorite(item)) {
                                                favoriteModel
                                                    .removeFavorite(item);
                                              } else {
                                                favoriteModel.addFavorite(item);
                                              }
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
