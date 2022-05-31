import '../core/model/crossword_model.dart';
import '../core/model/word_model.dart';

abstract class CrosswordState{
}

class CrosswordStateLoading  extends CrosswordState{
}

class CrosswordStateInit  extends CrosswordState{
}

class CrosswordStateLoaded extends CrosswordState {
  final CrosswordModel crosswordModel;
  final List<WordModel> learnLangModel;
  CrosswordStateLoaded(this.crosswordModel, this.learnLangModel);
}

class CrosswordStateCompleted extends CrosswordState {}

class CrosswordStateOver extends CrosswordState {}