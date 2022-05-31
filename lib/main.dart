import 'dart:io';

import 'package:crossword_learn/core/service/iwords_service.dart';
import 'package:crossword_learn/crossword/crossword_event.dart';
import 'package:crossword_learn/language/welcome_language_page.dart';
import 'package:crossword_learn/menu/menu_bloc.dart';
import 'package:crossword_learn/vocabulary/vocabulary_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'core/constant.dart';
import 'core/injection.dart';
import 'crossword/crossword_bloc.dart';
import 'language/language_bloc.dart';
import 'navigation/app_navigation.dart';

Future<void> main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initLocale();

  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('uk'),
        Locale('ru'),
        Locale('ar'),
        Locale('pt'),
        Locale('es'),
        Locale('hi')
      ],
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}

Future<void> initLocale() async {
  var sharedPref =  await SharedPreferences.getInstance();
  var language = sharedPref.getString(sharedPrefLanguage);
  if (language == null) {
    String localeName = Platform.localeName;
    String codeLanguage = localeName.split('_')[0];
    if (codeLanguage == 'ar' ||
        codeLanguage == 'en' ||
        codeLanguage == 'hi' ||
        codeLanguage == 'ua' ||
        codeLanguage == 'ru' ||
        codeLanguage == 'es' ||
        codeLanguage == 'pt') {
      language = codeLanguage;
    } else {
      language = 'en';
    }
    sharedPref.setString(sharedPrefLanguage, language);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Crossabulary',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            colorScheme: const ColorScheme.dark(),
          ),
          home: MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => CrosswordBloc(getIt<IWordsService>())
                      ..add(CrosswordEventLoad())),
                BlocProvider(
                    create: (context) => VocabularyBloc(getIt<IWordsService>())),
                BlocProvider(
                    create: (context) =>
                        LanguageBloc()..add(LanguageEventCheck())),
                BlocProvider(
                    create: (context) => MenuBloc()..add(MenuEventCheck())),
              ],
              child: BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, state) {
                if (state.learnLanguage != null &&
                    state.currentLanguage != null) {
                  return const AppNavigation();
                } else {
                  return const WelcomeLanguagePage();
                }
              })));}
}
