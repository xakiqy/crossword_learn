import 'dart:math';
import 'package:crossword_learn/core/model/crossword_model.dart';
import 'package:collection/collection.dart';
import '../game_done_exception.dart';
import '../model/word_model.dart';


class CrossWordService{
  final List<WordModel> words;
  List<int> blockedWordsIndexes;
  late int verticalWordIndex;
  late int verticalWordPlace;
  late int maxSymbols;
  late WordModel verticalWord;
  List<String> keyBoardLetters = [];
  List<WordModel> horizontalWords = [];
  Map<Pair, String> uiWords = {};
  Map<Pair, String> answeredUiWords = {};
  final String completedTableName;
  Map<Pair, String> correctChars = {};
  Map<int, String> correctWords = {};
  final Map<int, String> helperWord = {};
  CrossWordService(this.words, this.blockedWordsIndexes, this.completedTableName){
    _setCrosswords();
  }

  CrosswordModel getCrossWord() => CrosswordModel(verticalWord, horizontalWords, uiWords,
      verticalWordPlace, keyBoardLetters, completedTableName, maxSymbols, answeredUiWords, correctChars, correctWords, helperWord);

  void _setCrosswords() {

    verticalWordIndex = _getCentralWordIndex(words, blockedWordsIndexes);
    blockedWordsIndexes.add(verticalWordIndex);

    verticalWord = words.firstWhere((element) => element.id == verticalWordIndex);

    var charsVerticalWord = verticalWord.word.split('');

    for(int i = 0; i < charsVerticalWord.length; i++){
      var wordWithChar = _getWordContainChar(words, charsVerticalWord[i], blockedWordsIndexes);
      horizontalWords.add(words.firstWhere((element) => element.id == wordWithChar));
    }

    _getUiWords(charsVerticalWord);

    _getKeyboardChars(horizontalWords);
  }

  void _getKeyboardChars(List<WordModel> words) {
    for(var word in words){
      for(var char in word.word.split('')){
        if(!keyBoardLetters.contains(char)){
          keyBoardLetters.add(char);
        }
      }
    }
    keyBoardLetters.sort((a,b) => a.compareTo(b));

  }

  void _getUiWords(List<String> charsVerticalWord) {
    var maxCharsToVW = 0;
    var maxCharsFromVW = 0;

    for(int i = 0; i < horizontalWords.length; i++){
      for(int j = 0; j < horizontalWords[i].word.length; j++) {
        if(horizontalWords[i].word.split('')[j]  == charsVerticalWord[i]){
          var charsToVW = j;
          if(charsToVW > maxCharsToVW) {
            maxCharsToVW = charsToVW;
          }
          var charsFromVW = horizontalWords[i].word.length - j;
          if(charsFromVW > maxCharsFromVW) {
            maxCharsFromVW = charsFromVW;
          }
          break;
        }
      }
    }
    verticalWordPlace = maxCharsToVW;

    maxSymbols = maxCharsFromVW + maxCharsToVW;

    List<String> uiWordsList = [];

    for(int i = 0; i < horizontalWords.length; i++){
      var uiWord = horizontalWords[i].word;
      for(int j = 0; j < horizontalWords[i].word.length; j++) {
        var hwChars = horizontalWords[i].word.split('')[j];
        if(hwChars  == charsVerticalWord[i]){
          var charsToVW = j;
          if(charsToVW < maxCharsToVW) {
            var emptySymbols = '';
            for (int i = 0; i < maxCharsToVW - charsToVW; i++) {
              emptySymbols += '+';
            }
            uiWord = emptySymbols + uiWord;
          }
          var charsFromVW = horizontalWords[i].word.length - j;
          if(charsFromVW < maxCharsFromVW) {
            var emptySymbols = '';
            for (int i = 0; i < maxCharsFromVW - charsFromVW; i++) {
              emptySymbols += '+';
            }
            uiWord = uiWord + emptySymbols;
          }
          break;
        }
      }
      uiWordsList.add(uiWord);
    }

    for(int i = 0; i < uiWordsList.length; i++){
      for(int j = 0; j < uiWordsList[i].length; j ++){
        var splitWord = uiWordsList[i].split('');
        if(splitWord[j] != '+'){
          uiWords[Pair(i,j)] = splitWord[j];
          answeredUiWords[Pair(i,j)] = '';
        }
      }
    }

  }

  int _getCentralWordIndex(List<WordModel> words, List<int> blockedWordsIndexes){
    var wordIndex = -1;
    var maxTries = 3000;
    var verticalWordLength = 5;
    while(wordIndex == -1) {
      var tempWordIndex = Random().nextInt(2395);
      var word = words.firstWhereOrNull((element) => element.id == tempWordIndex)?.word;
      if(word != null && !blockedWordsIndexes.contains(tempWordIndex) && word.length > verticalWordLength){
        wordIndex = tempWordIndex;
      } else {
        maxTries--;
        if(maxTries < 0) {
          if(verticalWordLength < 3) {
            throw GameDoneException('game over');
          }
          verticalWordLength--;
          maxTries = 3000;
        }
      }
    }
    return wordIndex;
  }

  int _getWordContainChar(List<WordModel> words, String char, List<int> blockedWordsIndexes){
    var wordIndex = -1;
    var maxTries = 3000;
    var maxLength = 7;
    while(wordIndex == -1) {
      var tempWordIndex = Random().nextInt(2395);
      var word = words.firstWhereOrNull((element) => element.id == tempWordIndex)?.word;
      if(word != null && word.length < maxLength && !blockedWordsIndexes.contains(tempWordIndex) && word.split('').contains(char)){
        wordIndex = tempWordIndex;
      } else {
        maxTries--;
        if(maxTries < 0) {
          maxLength++;
          if(maxLength > 20) {
            throw GameDoneException('game over');
          }
          maxTries = 3000;
        }
      }
    }
    return wordIndex;
  }
}