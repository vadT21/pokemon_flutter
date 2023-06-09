import 'package:path/path.dart';
import 'dart:convert';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'pokemon_flutter_database.db';
  static const _databaseVersion = 1;

  static const table = 'pokemon';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnImageUrl = 'image_url';
  static const columnWeight = 'weight';
  static const columnHeight = 'height';
  static const columnTypes = 'types';
  static const columnStats = 'stats';

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
        $columnImageUrl TEXT NOT NULL,
        $columnWeight INTEGER,
        $columnHeight INTEGER, 
        $columnTypes TEXT,
        $columnStats TEXT
      )
    ''');
  }

  static Future<int> insertPokemon(Pokemon pokemon) async {
    final db = await database;

    // Проверяем, есть ли покемон уже в базе данных
    final existingPokemon = await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [pokemon.id],
      limit: 1,
    );

    if (existingPokemon.isNotEmpty) {
      // Если покемон уже есть в базе данных, возвращаем его идентификатор
      return existingPokemon.first[columnId] as int;
    } else {
      // Вставляем нового покемона в базу данных
      final typesJson = jsonEncode(pokemon.types);
      final statsJson = jsonEncode(pokemon.stats);

      return db.insert(
        table,
        {
          columnId: pokemon.id,
          columnName: pokemon.name,
          columnImageUrl: pokemon.imageUrl,
          columnWeight: pokemon.weight,
          columnHeight: pokemon.height,
          columnTypes: typesJson,
          columnStats: statsJson,
        },
      );
    }
  }

  // получение списка покемонов из базы данных
  static Future<List<Pokemon>> getPokemonList() async {
    final db = await database;
    final results = await db.query(table) as List<Map<String, dynamic>>;
    return results
        .map((result) => Pokemon(
            id: result[columnId],
            name: result[columnName],
            imageUrl: result[columnImageUrl],
            weight: result[columnWeight],
            height: result[columnHeight],
            types: jsonDecode(result[columnTypes]),
            stats: jsonDecode(result[columnStats])))
        .toList();
  }

  // возвращает количество элементов в таблице, нужно для последующего
  //запроса к API
  static Future<int> countItems() async {
    final db = await database;
    final tableExists = await _tableExists(db, table);
    if (!tableExists) {
      return 0;
    }
    final count = Sqflite.firstIntValue(
            await db.rawQuery("SELECT COUNT(*) FROM '$table'")) ??
        0;
    return count;
  }

  // проверка на существование базы данных
  static Future<bool> _tableExists(Database db, String tableName) async {
    final tableCount = Sqflite.firstIntValue(await db.rawQuery('''
      SELECT COUNT(*) FROM sqlite_master 
      WHERE type = 'table' AND name = '$tableName'
      '''));
    return tableCount == 1;
  }
}
