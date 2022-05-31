import 'package:crossword_learn/core/model/crossword_model.dart';

import '../model/word_model.dart';
abstract class IWordsService{

  Future<CrosswordModel> getCrosswords(String learnTableName, String currentTableName);

  Future<List<WordModel>> getWordsById(String tableName, List<int> listId);

  Future<List<WordModel>> getWordsByTableName(String tableName);

  Future<List<int>> getCompletedWordsIds(String tableName);

  void addCompletedWord(String tableName, int id);
}