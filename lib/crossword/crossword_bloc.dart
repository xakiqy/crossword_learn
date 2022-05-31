import 'package:crossword_learn/core/model/crossword_model.dart';
import 'package:crossword_learn/core/service/iwords_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constant.dart';
import '../core/game_done_exception.dart';
import '../core/model/word_model.dart';
import 'crossword_event.dart';
import 'crossword_state.dart';

class CrosswordBloc extends Bloc<CrosswordEvent, CrosswordState> {
  CrosswordBloc(this._wordsService) : super(CrosswordStateInit()) {
    on<CrosswordEventType>(_onWordChanged);
    on<CrosswordEventLoad>(_onWordsLoading);
    on<CrosswordEventComplete>(_onCrosswordComplete);
  }

  final IWordsService _wordsService;
  late CrosswordModel crosswordModel;
  late List<WordModel> learnLangWords;

  void _onWordsLoading(
      CrosswordEventLoad event, Emitter<CrosswordState> emit) async {
    emit(CrosswordStateLoading());
    var sharedPref = await SharedPreferences.getInstance();

    var learnWordsLang = sharedPref.getString(sharedPrefLL);
    var currentWordsLang = sharedPref.getString(sharedPrefCL);

    try {
      crosswordModel =
      await _wordsService.getCrosswords(learnWordsLang!, currentWordsLang!);

      learnLangWords = await _wordsService.getWordsById(
          currentWordsLang, getWordsIds(crosswordModel));

      emit(CrosswordStateLoaded(crosswordModel, learnLangWords));

    } on GameDoneException {
      emit(CrosswordStateOver());
    }
  }

  void _onWordChanged(CrosswordEventType event, Emitter<CrosswordState> emit) {
    emit(CrosswordStateLoading());
  }

  void _onCrosswordComplete(CrosswordEventComplete event, Emitter<CrosswordState> emit) {
    emit(CrosswordStateCompleted());
  }

  List<int> getWordsIds(CrosswordModel crosswordModel) {
    List<int> wordsIds = [];
    wordsIds.add(crosswordModel.verticalWord.id);
    wordsIds.addAll(crosswordModel.horizontalWords.map((e) => e.id).toList());
    return wordsIds;
  }
}
