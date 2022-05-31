

import 'package:crossword_learn/core/model/word_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class IDatabaseRepository {

  Future<Database> getDatabase();

  Future<List<WordModel>> getWords(String tableName);

  Future<List<WordModel>> getWordsById(String tableName, List<int> listId);

  Future<List<int>> getCompletedWordsIds(String tableName);

  void addCompletedWord(String tableName, int id);
}