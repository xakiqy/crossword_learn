
import 'package:crossword_learn/core/model/word_model.dart';

class Pair {
   final int i;
   final int j;

  Pair(this.i, this.j);

   @override
  bool operator ==(Object other) {
     if (other is! Pair) {
       return false;
     }
     return other.i == i && other.j == j;
  }

  @override
  // TODO: implement hashCode
  int get hashCode  {
     return i*j;
  }

   @override
  String toString() {
    return '$i $j';
  }
}
class CrosswordModel{
  final List<WordModel> horizontalWords;
  final WordModel verticalWord;
  final Map<Pair, String> uiWords;
  final Map<Pair, String> answeredUiWords;
  final int verticalWordPlace;
  final int maxSymbols;
  final List<String> keyboardChars;
  final String completedTableName;
  final Map<Pair, String> correctChars;
  final Map<int, String> correctWords;
  final Map<int, String> helperWord;
  CrosswordModel(this.verticalWord, this.horizontalWords, this.uiWords,
      this.verticalWordPlace, this.keyboardChars, this.completedTableName, this.maxSymbols,
      this.answeredUiWords, this.correctChars, this.correctWords, this.helperWord);
}