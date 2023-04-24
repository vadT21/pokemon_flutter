import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/screens/pokemon_detail.dart';
import 'package:pokemon_flutter/services/pokemon_db.dart';
import 'package:pokemon_flutter/services/pokemon_api_service.dart';

class PokemonHomePage extends StatefulWidget {
  @override
  _PokemonHomePageState createState() => _PokemonHomePageState();
}

class _PokemonHomePageState extends State<PokemonHomePage> {
  List<Pokemon> _pokemonList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon application'),
      ),
      body: _pokemonList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: _pokemonList.map((pokemon) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetailScreen(
                          pokemon: pokemon,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                            BlendMode.srcATop,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('#${pokemon.id}'),
                              Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.network(
                                  pokemon.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            pokemon.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                  blurRadius: 5,
                                  color: Colors.grey,
                                  offset: Offset(1, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Wrap(
                                spacing: 8.0,
                                children: pokemon.types
                                    .map(
                                      (type) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          '$type',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void fetchData() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final countItems = await DatabaseHelper.countItems();
    final currentPage = (countItems / 10).toInt();
    if (connectivityResult == ConnectivityResult.none) {
      // нет подключения к интернету
    } else {
      // есть подключение к интернету
      final apiData = await fetchPokemonList(currentPage);
      // Сохраняем данные в базу данных
      for (final pokemon in apiData) {
        await DatabaseHelper.insertPokemon(pokemon);
      }
    }
    final pokemonList = await DatabaseHelper.getPokemonList();
    setState(() {
      _pokemonList = pokemonList;
    });
  }
}
