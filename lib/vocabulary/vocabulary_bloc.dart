import 'package:crossword_learn/core/helper.dart';
import 'package:crossword_learn/core/model/word_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constant.dart';
import '../core/service/iwords_service.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {
  VocabularyBloc(this._wordsService) : super(VocabularyStateInit()) {
    on<VocabularyEventLoad>(_onWordsLoading);
  }

  final IWordsService _wordsService;

  void _onWordsLoading(
      VocabularyEventLoad event, Emitter<VocabularyState> emit) async {

    var sharedPref = await SharedPreferences.getInstance();

    var learnWordsLang = sharedPref.getString(sharedPrefLL);
    var currentWordsLang = sharedPref.getString(sharedPrefCL);

    var learnWords = await _wordsService.getWordsByTableName(learnWordsLang!);
    var currentWords  = await _wordsService.getWordsByTableName(currentWordsLang!);

    var doneWordsIndexes = await _wordsService.getCompletedWordsIds(getCompletedTableName(learnWordsLang, currentWordsLang));

    var learnWordsCompleted = learnWords.where((e) => doneWordsIndexes.contains(e.id)).toList();
    var currentWordsCompleted = currentWords.where((e) => doneWordsIndexes.contains(e.id)).toList();

    emit(VocabularyStateLoaded(learnWords, currentWords, learnWordsCompleted, currentWordsCompleted));
  }
}

abstract class VocabularyEvent{}

class VocabularyEventLoad extends VocabularyEvent {}

abstract class VocabularyState{}

class VocabularyStateInit extends VocabularyState {}

class VocabularyStateLoaded extends VocabularyState {
  final List<WordModel> learnWords;
  final List<WordModel> currentWords;

  final List<WordModel> learnWordsCompleted;
  final List<WordModel> currentWordsCompleted;

  VocabularyStateLoaded(this.learnWords, this.currentWords, this.learnWordsCompleted, this.currentWordsCompleted);
}