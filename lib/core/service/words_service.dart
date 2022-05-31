import 'package:crossword_learn/core/helper.dart';
import 'package:crossword_learn/core/service/crossword_service.dart';
import 'package:injectable/injectable.dart';
import '../model/crossword_model.dart';
import '../model/word_model.dart';
import '../repository/iwords_repository.dart';
import 'iwords_service.dart';

@Injectable(as: IWordsService)
class WordsService implements IWordsService {
  final IWordsRepository _wordsRepository;

  WordsService(this._wordsRepository);

  @override
  Future<CrosswordModel> getCrosswords(String learnTableName, String currentTableName) async {
    var words = await _wordsRepository.getWords(learnTableName);
    var completedTableName = getCompletedTableName(learnTableName, currentTableName);

    var completedWordsIds = await _wordsRepository.getCompletedWordsIds(completedTableName);

    CrossWordService crossWordService = CrossWordService(words, completedWordsIds, completedTableName);

    return crossWordService.getCrossWord();
  }

  @override
  Future<List<WordModel>> getWordsById(String tableName, List<int> listId) async{
    var words = await _wordsRepository.getWordsById(tableName, listId);

    return words;
  }

  @override
  void addCompletedWord(String tableName, int id) {
    _wordsRepository.addCompletedWord(tableName, id);
  }

  @override
  Future<List<WordModel>> getWordsByTableName(String tableName) async {
    var words = await _wordsRepository.getWords(tableName);
    return words;
  }

  @override
  Future<List<int>> getCompletedWordsIds(String tableName) async {

    return _wordsRepository.getCompletedWordsIds(tableName);
  }
}
