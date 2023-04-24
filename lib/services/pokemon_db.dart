import 'package:path/path.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'pokemon_database.db';
  static final _databaseVersion = 1;

  static final table = 'pokemon';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnImageUrl = 'image_url';

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnImageUrl TEXT NOT NULL
      )
    ''');
  }

  static Future<int> insertPokemon(Pokemon pokemon) async {
    final db = await database;

    // Проверяем, есть ли покемон уже в базе данных
    final pokemonList = await getPokemonList();
    final existingPokemon =
        pokemonList.firstWhere((element) => element.id == pokemon.id);

    if (existingPokemon != null) {
      // Если покемон уже есть в базе данных, возвращаем его идентификатор
      return existingPokemon.id;
    } else {
      // Вставляем нового покемона в базу данных
      return db.insert(
        table,
        {
          columnId: pokemon.id,
          columnName: pokemon.name,
          columnImageUrl: pokemon.imageUrl,
        },
      );
    }
  }

  static Future<List<Pokemon>> getPokemonList() async {
    final db = await database;
    final results = await db.query(table) as List<Map<String, dynamic>>;
    return results
        .map((result) => Pokemon(
              id: result[columnId],
              name: result[columnName],
              imageUrl: result[columnImageUrl],
            ))
        .toList();
  }
}
