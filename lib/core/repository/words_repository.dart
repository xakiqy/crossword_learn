import 'package:crossword_learn/core/repository/idatabase_repository.dart';
import 'package:injectable/injectable.dart';
import '../model/word_model.dart';
import 'iwords_repository.dart';

@Injectable(as: IWordsRepository)
class WordsRepository extends IWordsRepository{
  final IDatabaseRepository _databaseRepository;

  WordsRepository(this._databaseRepository);

  @override
  Future<List<WordModel>> getWords(String tableName) async {

    return _databaseRepository.getWords(tableName);
  }

  @override
  Future<List<WordModel>> getWordsById(String tableName, List<int> listId) async{

    return _databaseRepository.getWordsById(tableName, listId);
  }

  @override
  Future<List<int>> getCompletedWordsIds(String tableName) async {

    return _databaseRepository.getCompletedWordsIds(tableName);
  }

  @override
  void addCompletedWord(String tableName, int id){

    return _databaseRepository.addCompletedWord(tableName, id);
  }
}