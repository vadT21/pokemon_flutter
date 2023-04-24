import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/screens/pokemon_detail.dart';
import 'package:pokemon_flutter/services/pokemon_db.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text('Pokedex'),
      ),
      body: _pokemonList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
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
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(pokemon.imageUrl),
                        ),
                        Text(pokemon.name),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }

  void fetchData() async {
    final pokemonList = await DatabaseHelper.getPokemonList();
    setState(() {
      _pokemonList = pokemonList;
    });
  }
}