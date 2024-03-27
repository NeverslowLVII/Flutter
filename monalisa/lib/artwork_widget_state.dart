import 'package:flutter/material.dart';
import 'package:monalisa/artwork_widget.dart';

class ArtworkWidgetState extends State<ArtworkWidget> {
  bool _isFavorite = false;
  bool _showDescription = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      if (_isFavorite) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Oeuvre ajoutée à vos favoris'),
            duration: Duration(milliseconds: 1500),
          ),
        );
      }
    });
  }

  void _toggleDescription() =>
      setState(() => _showDescription = !_showDescription);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Œuvre d\'art')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('images/Mona_Lisa.jpg',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth),
                    Icon(Icons.favorite,
                        size: 100,
                        color: _isFavorite
                            ? Colors.red.withOpacity(1.0)
                            : Colors.white.withOpacity(0.25)),
                    if (_showDescription)
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: Colors.white.withOpacity(0.25),
                            child: const SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "La Joconde, ou Portrait de Mona Lisa, est un tableau de l'artiste Léonard de Vinci, réalisé entre 1503 et 1506 ou entre 1513 et 15161,2, et peut-être jusqu'à 1517 (l'artiste étant mort le 2 mai 1519), qui représente un portrait mi-corps, probablement celui de la Florentine Lisa Gherardini, épouse de Francesco del Giocondo. Acquise par François Ier, cette peinture à l'huile sur panneau de bois de peuplier de 77 × 53 cm est exposée au musée du Louvre à Paris. La Joconde est l'un des rares tableaux attribués de façon certaine à Léonard de Vinci.\n\nLa Joconde est devenue un tableau éminemment célèbre car, depuis sa réalisation, nombre d'artistes l'ont pris comme référence. À l'époque romantique, les artistes ont été fascinés par ce tableau et ont contribué à développer le mythe qui l'entoure, en faisant de ce tableau l’une des œuvres d'art les plus célèbres du monde, si ce n'est la plus célèbre : elle est en tout cas considérée comme l'une des représentations d'un visage féminin les plus célèbres au monde. Au xxie siècle, elle est devenue l'objet d'art le plus visité au monde, devant le diamant Hope, avec 20 000 visiteurs qui viennent l'admirer et la photographier quotidiennement.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const Text('Mona Lisa',
                    style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontSize: 30,
                        color: Colors.brown)),
                const Text('Léonard de Vinci',
                    style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.brown)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.article),
                        onPressed: _toggleDescription),
                    IconButton(
                        icon: Icon(Icons.favorite,
                            color: _isFavorite ? Colors.red : Colors.brown),
                        onPressed: _toggleFavorite),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
