
import '../model/word_model.dart';

abstract class IWordsRepository {

  Future<List<WordModel>> getWords(String tableName);

  Future<List<WordModel>> getWordsById(String tableName, List<int> listId);

  Future<List<int>> getCompletedWordsIds(String tableName);

  void addCompletedWord(String tableName, int id);
}