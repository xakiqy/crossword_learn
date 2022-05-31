import 'package:crossword_learn/vocabulary/vocabulary_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../general_widgets/app_bar_word_point.dart';
import '../util/screen_size_reducer.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({Key? key}) : super(key: key);

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  int index = 0;
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
        title: Text(
          'vocabulary'.tr(),
          style: Theme.of(context).textTheme.headline5!.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: WordsAndPoints(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0x40575757),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.keyboard_arrow_down),
            label: 'done-words'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.apps_sharp),
            label: 'all-words'.tr(),
          ),
        ],
        currentIndex: index,
        selectedItemColor: Colors.green,
        onTap: (i) {setState(() {
          index = i;
        });},
      ),
      body: Column(
        children: [
          BlocBuilder<VocabularyBloc, VocabularyState>(
              builder : (context, state) {
                if(state is VocabularyStateLoaded){
                  if(index == 0){
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.learnWordsCompleted.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(state.currentWordsCompleted[index].word + ' - ' +
                                      state.learnWordsCompleted[index].word, style: const TextStyle(fontSize: 18, color: Colors.green))
                                ],
                              ),
                            );
                          }),
                    );
                  }else {
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.currentWords.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(state.currentWords[index].word + ' - ' +
                                      state.learnWords[index].word, style: const TextStyle(fontSize: 20)),
                                  SizedBox(
                                    width: screenWidth(context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                          state.learnWords[index].example ?? '', style: const TextStyle(fontSize: 16)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  }
                }
                return Container();
              }
          )
        ],
      ),
    );
  }
}