
import 'package:crossword_learn/core/injection.dart';
import 'package:crossword_learn/core/model/word_model.dart';
import 'package:crossword_learn/crossword/crossword_bloc.dart';
import 'package:crossword_learn/crossword/crossword_event.dart';
import 'package:crossword_learn/crossword/crossword_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:just_audio/just_audio.dart';

import '../core/model/crossword_model.dart';
import '../core/repository/iwords_repository.dart';
import '../general_widgets/app_bar_word_point.dart';
import '../menu/menu_bloc.dart';
import '../util/screen_size_reducer.dart';

class CrosswordPage extends StatefulWidget {
  const CrosswordPage({Key? key}) : super(key: key);

  @override
  State<CrosswordPage> createState() => _CrosswordPageState();
}

class _CrosswordPageState extends State<CrosswordPage> {
  
  int chosenWord = 0;
  int chosenSymbol = 0;
  bool wrongWord = false;
  bool isKeyboard = false;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: 0,
        title: Text(
          'crossword'.tr(),
          style: const TextStyle(fontSize: 20.0, color: Colors.green)
        ),
        actions: [
          const WordsAndPoints(),
          IconButton(onPressed: (){
            showDialog<bool>(context: context, builder: (context){
              return AlertDialog(
              title: Text('start-new-crossword'.tr(), ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop<bool>(true);
                  },
                  child: Text('yes'.tr(), style: const TextStyle(fontSize: 16.0)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop<bool>(false);
                  },
                  child: Text('no'.tr(), style: const TextStyle(fontSize: 18.0)),
                ),
              ],
            );}).then((value) {
              if(value == true) {
                setState(() {
                  chosenWord = 0;
                  chosenSymbol = 0;
                  isKeyboard = false;
                });
                BlocProvider.of<CrosswordBloc>(context).add(CrosswordEventLoad());
              }
            })
            ;
          }, icon: const Icon(Icons.wifi_protected_setup),
          tooltip: 'swap-crossword'.tr(),)
        ],
      ),
      body: BlocBuilder<CrosswordBloc, CrosswordState>(builder: (context, state) {
        if (state is CrosswordStateLoaded) {
          return SizedBox(
            height: screenHeight(context) - kToolbarHeight,
            child: Column(
              children: [
                   Container(
                    height: screenHeight(context, dividedBy: 3) -
                         - kToolbarHeight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: getWords(state.crosswordModel, context),
                          ),
                        ),
                      ),

                  ),
                ),
                keyboardWordLine(
                    context, state.crosswordModel, state.learnLangModel),
              ],
            ),
          );
        } else if (state is CrosswordStateLoaded) {
          return const CircularProgressIndicator();
        } else if (state is CrosswordStateCompleted) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: screenWidth(context),
                  child: Center(child: Text('crossword-complete'.tr(), style: const TextStyle(fontSize: 22.0, color: Colors.green)))),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                       chosenWord = 0;
                       chosenSymbol = 0;
                       isKeyboard = false;
                    });
                    context.read<MenuBloc>().add(MenuEventAddPointsAndWord(100, 0));
                    context.read<CrosswordBloc>().add(CrosswordEventLoad());
                  },
                  child: Text('start-new-crossword'.tr(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 18.0)),
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    primary: Colors.white,
                    onPrimary: Colors.green,
                  ),
                ),
              ),
            ],
          );
        } else if (state is CrosswordStateOver) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: screenWidth(context),
                  child: Center(child: Text('crossword-over-game'.tr(), style: const TextStyle(fontSize: 22.0, color: Colors.green)))),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('change-over-language'.tr(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 18.0)),
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    primary: Colors.white,
                    onPrimary: Colors.green,
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      }),
    );
  }

  Widget getWordQuestion(
      CrosswordModel crosswordModel, List<WordModel> wordModelList, context) {
    var word = crosswordModel.verticalWord;
    var helperWord = crosswordModel.verticalWord.word;
    if (chosenWord != crosswordModel.verticalWord.word.length) {
      word = wordModelList.firstWhere((element) =>
          element.id == crosswordModel.horizontalWords[chosenWord].id);
      helperWord = crosswordModel.horizontalWords[chosenWord].word;
    } else {
      word = wordModelList.firstWhere(
          (element) => element.id == crosswordModel.verticalWord.id);
      helperWord = crosswordModel.verticalWord.word;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(word.question ?? '', style: const TextStyle(fontSize: 18)),
        ),
        BlocBuilder<MenuBloc, MenuState>(builder: (context, state){
            if(crosswordModel.helperWord.containsKey(chosenWord)) {
              return Text(helperWord,
                  style: const TextStyle(fontSize: 18, color: Colors.green));
            } else if(state.points >= 100 && !crosswordModel.correctWords.containsKey(chosenWord)){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('get-help'.tr(),  style: const TextStyle(fontSize: 16)),
                    IconButton(onPressed: (){
                      context.read<MenuBloc>().add(MenuEventGetAnswer());
                      crosswordModel.helperWord[chosenWord] = 'true';
                    }, icon: const Icon(Icons.help_outline), tooltip: '100-points'.tr(),),
                  ],
                ),
              );
          }
            return Container();
        }),

      ],
    );
  }

  List<Row> getWords(CrosswordModel crossword, context) {
    List<Row> uiWords = [];
    var containerSize = 25.0;

    for (int i = 0; i < crossword.verticalWord.word.length; i++) {
      List<Padding> charContainer = [];
      for (int j = 0; j < crossword.maxSymbols; j++) {
        if (crossword.answeredUiWords.containsKey(Pair(i, j))) {
          charContainer.add(Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: chosenWord == i
                            ? Colors.blueAccent
                            : crossword.verticalWordPlace == j
                                ? Colors.orange
                                : Colors.grey,
                        width: 1.0)),
                child: SizedBox(
                    height: 25,
                    width: containerSize,
                    child: Center(
                        child: Text(crossword.answeredUiWords[Pair(i, j)]!, style: const TextStyle(fontSize: 16),)))),
          ));
        } else {
          charContainer.add(Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(height: 25, width: containerSize),
          ));
        }
      }
      uiWords.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: charContainer));
    }
    return uiWords;
  }

  Widget keyboardWordLine(BuildContext context, CrosswordModel crosswordModel,
      List<WordModel> wordModelList) {
    return Container(
      width: screenWidth(context),
      child: Column(
        children: [
          wrongWord
              ? ShakeWidget(
                  onAnimationEnd: () {
                    wrongWord = false;
                  },
                  child: keyboardContainer(crosswordModel),
                )
              : Container(child: keyboardContainer(crosswordModel)),
          getOptionButtons(crosswordModel),
          isKeyboard
              ? getBottomPanel(crosswordModel, context)
              : getWordQuestion(crosswordModel, wordModelList, context)
        ],
      ),
    );
  }

  Row getOptionButtons(CrosswordModel crosswordModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              await audioPlayer.setAsset('assets/switch.mp3');
              audioPlayer.play();
              setAvailableSymbol(crosswordModel);
              setState(() {
                isKeyboard = true;
              });
            },
            child: SizedBox(
                width: screenWidth(context, dividedBy: 4),
                child: Center(child: Text('keyboard'.tr(), style: const TextStyle(fontSize: 16)))),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(18.0),
              ),
              elevation: 6,
              primary: isKeyboard ? Colors.grey.shade400 : Colors.white,
              onPrimary: Colors.green,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () async{
              await audioPlayer.setAsset('assets/switch.mp3');
              audioPlayer.play();
              setState(() {
                isKeyboard = false;
              });
            },
            child: SizedBox(
                width: screenWidth(context, dividedBy: 4),
                child: Center(child: Text('question'.tr(), style: const TextStyle(fontSize: 16)))),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(18.0),
              ),
              elevation: 6,
              primary: isKeyboard ? Colors.white : Colors.grey.shade400,
              onPrimary: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Container keyboardContainer(CrosswordModel crosswordModel) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(
                  color: crosswordModel.correctWords.containsKey(chosenWord)
                      ? Colors.green
                      : Colors.grey,
                  width: 2))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () async{
                await audioPlayer.setAsset('assets/switch.mp3');
                audioPlayer.play();
                setState(() {
                  isKeyboard = false;
                  if (chosenWord > 0) {
                    chosenWord--;
                  } else {
                    chosenWord = crosswordModel.horizontalWords.length;
                  }
                });
              },
              icon: const Icon(Icons.arrow_back_ios)),
          lineWord(crosswordModel),
          IconButton(
              onPressed: () async{
                await audioPlayer.setAsset('assets/switch.mp3');
                audioPlayer.play();
                setState(() {
                  isKeyboard = false;
                  if (chosenWord < crosswordModel.horizontalWords.length) {
                    chosenWord++;
                  } else {
                    chosenWord = 0;
                  }
                });
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }

  Row lineWord(CrosswordModel crosswordModel) {
    List<Text> charLine = [];

    if (chosenWord == crosswordModel.verticalWord.word.length) {
      for (int i = 0; i < crosswordModel.verticalWord.word.length; i++) {
        if (crosswordModel.answeredUiWords
            .containsKey(Pair(i, crosswordModel.verticalWordPlace))) {
          var char = crosswordModel
              .answeredUiWords[Pair(i, crosswordModel.verticalWordPlace)]!;
          if (char == '') {
            charLine.add(const Text('_', style: TextStyle(fontSize: 18)));
          } else {
            charLine.add(Text(char, style: const TextStyle(fontSize: 18)));
          }
        }
      }
    } else {
      for (int j = 0; j < crosswordModel.maxSymbols; j++) {
        if (crosswordModel.answeredUiWords.containsKey(Pair(chosenWord, j))) {
          var char = crosswordModel.answeredUiWords[Pair(chosenWord, j)]!;
          if (char == '') {
            charLine.add(const Text('_', style: TextStyle(fontSize: 18)));
          } else {
            charLine.add(Text(char, style: const TextStyle(fontSize: 18)));
          }
        }
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: charLine,
    );
  }

  Column getBottomPanel(CrosswordModel crosswordModel, context) {
    List<Row> bottomPanel = [];
    List<Padding> keyboard = [];
    for (var char in crosswordModel.keyboardChars) {
      keyboard.add(Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
        child: SizedBox(
          width: 39,
          height: 39,
          child: ElevatedButton(
            onPressed: () async{
              await audioPlayer.setAsset('assets/type.mp3');
              audioPlayer.play();
              if (!crosswordModel.correctWords.containsKey(chosenWord) &&
                  crosswordModel.answeredUiWords
                      .containsKey(Pair(chosenWord, chosenSymbol))) {
                setState(() {
                  crosswordModel
                      .answeredUiWords[Pair(chosenWord, chosenSymbol)] = char;
                });
                typeHorizontalChar(crosswordModel);
                setAvailableSymbol(crosswordModel);
              } else if (!crosswordModel.correctWords.containsKey(chosenWord) &&
                  chosenWord == crosswordModel.verticalWord.word.length) {
                setState(() {
                  crosswordModel.answeredUiWords[Pair(
                      chosenSymbol, crosswordModel.verticalWordPlace)] = char;
                });
                typeVerticalChar(crosswordModel);
                setAvailableSymbol(crosswordModel);
              }
            },
            child: Text(char, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(side: BorderSide(color: Colors.orange, width: 2)),
              elevation: 12,
              primary: Colors.white,
              onPrimary: Colors.green,
            ),
          ),
        ),
      ));
    }

    List<Padding> tempRow = [];

    for (int i = 0; i < keyboard.length; i++) {
      tempRow.add(keyboard[i]);
      if (i != 0 && i % 6 == 0) {
        bottomPanel.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: tempRow));
        tempRow = [];
      }
      if (i == keyboard.length - 1) {
        tempRow.add(Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Container(
            width: 35,
            height: 35,
            child: IconButton(
              onPressed: () {
                setState(() async {
                  await audioPlayer.setAsset('assets/eraser.mp3');
                  audioPlayer.play();
                  if (chosenWord == crosswordModel.verticalWord.word.length) {
                    for(int i = 1; i <= chosenSymbol; i++) {
                    if (!crosswordModel.correctChars.containsKey(Pair(chosenSymbol - i,
                            crosswordModel.verticalWordPlace)) &&
                        crosswordModel.answeredUiWords.containsKey(Pair(
                            chosenSymbol - i,
                            crosswordModel.verticalWordPlace))) {
                      crosswordModel.answeredUiWords[Pair(chosenSymbol - i,
                          crosswordModel.verticalWordPlace)] = '';
                      break;
                      }
                    }
                  } else {
                    for(int i = 1; i <= chosenSymbol; i++) {
                      if (!crosswordModel.correctChars
                          .containsKey(Pair(chosenWord, chosenSymbol - i)) &&
                          crosswordModel.answeredUiWords
                              .containsKey(Pair(
                              chosenWord, chosenSymbol - i))) {
                        crosswordModel.answeredUiWords[Pair(
                            chosenWord, chosenSymbol - i)] = '';
                        break;
                      }
                    }
                  }
                  setAvailableSymbol(crosswordModel);
                });
              },
              icon: const Icon(
                Icons.backspace_outlined,
                color: Colors.lightBlue,
              ),
            ),
          ),
        ));

        bottomPanel.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: tempRow));
      }
    }
    return Column(children: bottomPanel);
  }

  Future<void> typeHorizontalChar(CrosswordModel crosswordModel) async {
    var word = '';
    for (int j = 0; j < crosswordModel.maxSymbols; j++) {
      if (crosswordModel.answeredUiWords.containsKey(Pair(chosenWord, j))) {
        word += crosswordModel.answeredUiWords[Pair(chosenWord, j)]!;
      }
    }
    if (word == crosswordModel.horizontalWords[chosenWord].word) {
      setState(() {
        for (int j = 0; j < crosswordModel.maxSymbols; j++) {
          if (crosswordModel.answeredUiWords.containsKey(Pair(chosenWord, j))) {
            crosswordModel.correctChars[Pair(chosenWord, j)] =
                crosswordModel.answeredUiWords[Pair(chosenWord, j)]!;
          }
        }
      });

      getIt.get<IWordsRepository>().addCompletedWord(
          crosswordModel.completedTableName,
          crosswordModel.horizontalWords[chosenWord].id);
      context.read<MenuBloc>().add(MenuEventAddPointsAndWord(10, 1));
      crosswordModel.correctWords[chosenWord] =
          crosswordModel.horizontalWords[chosenWord].word;

        if(crosswordModel.correctWords.length == crosswordModel.horizontalWords.length
            && !crosswordModel.correctWords.containsKey(crosswordModel.verticalWord.word.length))
        {
          getIt.get<IWordsRepository>().addCompletedWord(
              crosswordModel.completedTableName, crosswordModel.verticalWord.id);
          context.read<MenuBloc>().add(MenuEventAddPointsAndWord(10, 1));
          crosswordModel.correctWords[crosswordModel.verticalWord.word.length] = crosswordModel.verticalWord.word;
        }

      if(crosswordModel.correctWords.length == crosswordModel.horizontalWords.length+1){
        Future.delayed(const Duration(seconds: 3)).then((value) => context.read<CrosswordBloc>().add(CrosswordEventComplete()));
        await audioPlayer.setAsset('assets/win.mp3');
        audioPlayer.play();
      }
    } else if (word.length ==
        crosswordModel.horizontalWords[chosenWord].word.length) {

      setState(() {
        wrongWord = true;
      });
      Future.delayed(const Duration(milliseconds: 300))
          .then((value) => setState(() {
                for (int j = 0; j < crosswordModel.maxSymbols; j++) {
                  if (crosswordModel.answeredUiWords
                          .containsKey(Pair(chosenWord, j)) &&
                      !crosswordModel.correctChars.containsKey(Pair(chosenWord, j))) {
                    crosswordModel.answeredUiWords[Pair(chosenWord, j)] = '';
                  }
                }
                setAvailableSymbol(crosswordModel);
              }));
    }
  }

  void setAvailableSymbol(CrosswordModel crosswordModel) {
    if (chosenWord != crosswordModel.verticalWord.word.length) {
      for (int j = 0; j < crosswordModel.maxSymbols; j++) {
        if (crosswordModel.uiWords.containsKey(Pair(chosenWord, j))) {
          if (crosswordModel.answeredUiWords[Pair(chosenWord, j)] == '') {
            setState(() {
              chosenSymbol = j;
            });
            break;
          }
        }
      }
    } else {
      for (int j = 0; j < crosswordModel.verticalWord.word.length; j++) {
        if (crosswordModel.uiWords
            .containsKey(Pair(j, crosswordModel.verticalWordPlace))) {
          if (crosswordModel
                  .answeredUiWords[Pair(j, crosswordModel.verticalWordPlace)] ==
              '') {
            setState(() {
              chosenSymbol = j;
            });
            break;
          }
        }
      }
    }
  }

  Future<void> typeVerticalChar(CrosswordModel crosswordModel) async {
    var word = '';
    for (int i = 0; i < crosswordModel.verticalWord.word.length; i++) {
      if (crosswordModel.answeredUiWords
          .containsKey(Pair(i, crosswordModel.verticalWordPlace))) {
        word += crosswordModel
            .answeredUiWords[Pair(i, crosswordModel.verticalWordPlace)]!;
      }
    }
    if (word == crosswordModel.verticalWord.word) {
      setState(() {
        for (int i = 0; i < crosswordModel.verticalWord.word.length; i++) {
          if (crosswordModel.answeredUiWords
              .containsKey(Pair(i, crosswordModel.verticalWordPlace))) {
            crosswordModel.correctChars[Pair(i, crosswordModel.verticalWordPlace)] =
                crosswordModel.answeredUiWords[
                    Pair(i, crosswordModel.verticalWordPlace)]!;
          }
        }
      });

      getIt.get<IWordsRepository>().addCompletedWord(
          crosswordModel.completedTableName, crosswordModel.verticalWord.id);
      context.read<MenuBloc>().add(MenuEventAddPointsAndWord(10, 1));
      crosswordModel.correctWords[chosenWord] = crosswordModel.verticalWord.word;
      if(crosswordModel.correctWords.length == crosswordModel.horizontalWords.length+1){
        Future.delayed(const Duration(seconds: 3)).then((value) => context.read<CrosswordBloc>().add(CrosswordEventComplete()));
        await audioPlayer.setAsset('assets/switch.mp3');
        audioPlayer.play();
      }
    } else if (word.length == crosswordModel.verticalWord.word.length) {
      await audioPlayer.setAsset('assets/switch.mp3');
      audioPlayer.play();
      setState(() {
        wrongWord = true;
      });
      Future.delayed(const Duration(milliseconds: 300)).then((value) =>
          setState(() {
            for (int i = 0; i < crosswordModel.verticalWord.word.length; i++) {
              if (crosswordModel.answeredUiWords
                      .containsKey(Pair(i, crosswordModel.verticalWordPlace)) &&
                  !crosswordModel.correctChars
                      .containsKey(Pair(i, crosswordModel.verticalWordPlace))) {
                crosswordModel.answeredUiWords[
                    Pair(i, crosswordModel.verticalWordPlace)] = '';
              }
            }
            setAvailableSymbol(crosswordModel);
          }));
    }
  }
}

class ShakeWidget extends StatelessWidget {
  final Duration duration;
  final double deltaX;
  final Widget child;
  final Curve curve;
  final VoidCallback onAnimationEnd;

  const ShakeWidget({
    Key? key,
    required this.onAnimationEnd,
    this.duration = const Duration(milliseconds: 500),
    this.deltaX = 20,
    this.curve = Curves.bounceOut,
    required this.child,
  }) : super(key: key);

  /// convert 0-1 to 0-1-0
  double shake(double animation) =>
      2 * (0.5 - (0.5 - curve.transform(animation)).abs());

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: key,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      onEnd: onAnimationEnd,
      builder: (context, animation, child) => Transform.translate(
        offset: Offset(deltaX * shake(animation), 0),
        child: child,
      ),
      child: child,
    );
  }
}
