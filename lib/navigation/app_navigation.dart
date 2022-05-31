import 'package:crossword_learn/crossword/crossword_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../language/language_page.dart';
import '../learn_word/learn_word_page.dart';
import '../menu/menu_page.dart';
import '../vocabulary/vocabulary_page.dart';


class AppNavigation extends StatelessWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.dark(),
      ),
      // theme: documentOnlineTheme,
      initialRoute: '/menuPage',
      routes: {
        '/languagePage': (context) => const LanguagePage(),
        '/crosswordPage': (context) => const CrosswordPage(),
        '/menuPage': (context) => const MenuPage(),
        '/vocabularyPage': (context) => const VocabularyPage(),
      },
    );
  }
}
