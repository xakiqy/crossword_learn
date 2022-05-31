import 'dart:io';

import 'package:crossword_learn/core/model/word_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../constant.dart';
import 'idatabase_repository.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

@Injectable(as: IDatabaseRepository)
class DatabaseRepository extends IDatabaseRepository{

  @override
  Future<Database> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "crossword_local_db.db");
    // Check if the database exists
    var exists = await databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "crossword_db.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            for(int i = 0; i < tableWordsList.length; i++) {
              for (int j = 0; j < tableWordsList.length; j++) {
                  var tableName = tableWordsList[i] + tableWordsList[j];
                  await db.execute(
                      'CREATE TABLE $tableName (id INTEGER PRIMARY KEY)');
              }
            }
          });
    } else {
      print("Opening existing database");
    }
      // open the database
    var db = await openDatabase(path, readOnly: false);
    return db;
  }

  @override
  Future<List<WordModel>> getWords(String tableName) async {
    var db = await getDatabase();

    List<Map> maps = await db.query(tableName,
        columns: ['id', 'word', 'question', 'example'],
        );
    if (maps.isNotEmpty) {
      return maps.map((e) => WordModel.fromMap(e)).toList();
    }
    return [];
  }

  @override
  Future<List<WordModel>> getWordsById(String tableName, List<int> listId) async {
    var db = await getDatabase();

    List<Map> maps = await db.query(tableName,
      columns: ['id', 'word', 'question', 'example'],
      where: 'id IN (${List.filled(listId.length, '?').join(',')})',
      whereArgs: listId
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => WordModel.fromMap(e)).toList();
    }
    return [];
  }

  @override
  Future<List<int>> getCompletedWordsIds(String tableName) async {
    var db = await getDatabase();

    List<Map> maps = await db.query(tableName,
        columns: ['id'],
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => e['id'] as int).toList();
    }
    return [];
  }

  @override
  void addCompletedWord(String tableName, int id) async {
    var db = await getDatabase();
    var rowsInsert = <String, Object>{};
    rowsInsert['id'] = id;
    db.insert(tableName, rowsInsert);
  }

}