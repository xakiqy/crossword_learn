import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constant.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(null, null)) {
    on<LanguageEventChange>(_onLanguageChange);
    on<LanguageEventCheck>(_onLanguageCheck);
  }


  void _onLanguageChange(
      LanguageEventChange event, Emitter<LanguageState> emit) async {

    var sharedPref = await SharedPreferences.getInstance();

    sharedPref.setString(sharedPrefLL, event.learnLanguage);
    sharedPref.setString(sharedPrefCL, event.currentLanguage);

    emit(LanguageState(event.currentLanguage, event.learnLanguage));
  }

  void _onLanguageCheck(
      LanguageEventCheck event, Emitter<LanguageState> emit) async {

    var sharedPref = await SharedPreferences.getInstance();


    emit(LanguageState(sharedPref.getString(sharedPrefCL), sharedPref.getString(sharedPrefLL)));
  }
}

abstract class LanguageEvent{}

class LanguageEventCheck extends LanguageEvent{}

class LanguageEventChange extends LanguageEvent{
  final String currentLanguage;
  final String learnLanguage;

  LanguageEventChange(this.currentLanguage, this.learnLanguage);
}

class LanguageState{
  final String? currentLanguage;
  final String? learnLanguage;

  LanguageState(this.currentLanguage, this.learnLanguage);
}



