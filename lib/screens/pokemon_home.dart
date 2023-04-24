import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/screens/pokemon_detail.dart';
import 'package:pokemon_flutter/services/pokemon_db.dart';
import 'package:pokemon_flutter/services/pokemon_api_service.dart';
import 'package:pokemon_flutter/widgets/pokemon_card.dart';

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
        title: const Text('Pokemon application'),
      ),
      body: _pokemonList.isEmpty
          //если нету данных то показывается загрузка
          ? const Center(
              child: CircularProgressIndicator(),
            )
          //построение grid для отображения элементов
          : GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: _pokemonList.map((pokemon) {
                // отвечает за нажатие на элемент
                return GestureDetector(
                  // переход на дет. информацию при клике
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
                  // отрисовка элемента
                  child: PokemonCardWidget(pokemon: pokemon),
                );
              }).toList(),
            ),
      //кнопка для добавления элементов
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

// метод получения данных
  void fetchData() async {
    // проверяем доступ к интернету
    final connectivityResult = await Connectivity().checkConnectivity();
    //получаем количество элементов из базы данных
    final countItems = await DatabaseHelper.countItems();
    // получаем число с которого нужно загружать новые элементы
    final currentPage = (countItems ~/ 10).toInt();
    if (connectivityResult == ConnectivityResult.none) {
      // нет подключения к интернету
    } else {
      // есть подключение к интернету, делаем запрос к API
      final apiData = await fetchPokemonList(currentPage);
      // Сохраняем данные в базу данных
      for (final pokemon in apiData) {
        await DatabaseHelper.insertPokemon(pokemon);
      }
    }
    //получаем список из базы данных
    final pokemonList = await DatabaseHelper.getPokemonList();
    setState(() {
      _pokemonList = pokemonList;
    });
  }
}
