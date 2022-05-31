import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constant.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuState(0, 0)) {
    on<MenuEventAddPointsAndWord>(_onMenuAddPointsAndWord);
    on<MenuEventCheck>(_onMenuCheck);
    on<MenuEventGetAnswer>(_onMenuGetAnswer);
  }

  void _onMenuAddPointsAndWord(
      MenuEventAddPointsAndWord event, Emitter<MenuState> emit) async {
    var sharedPref = await SharedPreferences.getInstance();

    sharedPref.setInt(
        sharedPrefPoints, sharedPref.getInt(sharedPrefPoints)! + event.points);
    sharedPref.setInt(sharedPrefWordsCount,
        sharedPref.getInt(sharedPrefWordsCount)! + event.words);

    add(MenuEventCheck());
  }

  void _onMenuGetAnswer(
      MenuEventGetAnswer event, Emitter<MenuState> emit) async {
    var sharedPref = await SharedPreferences.getInstance();

    sharedPref.setInt(
        sharedPrefPoints, sharedPref.getInt(sharedPrefPoints)! - 100);

    add(MenuEventCheck());
  }

  void _onMenuCheck(MenuEventCheck event, Emitter<MenuState> emit) async {
    var sharedPref = await SharedPreferences.getInstance();

    var points = sharedPref.getInt(sharedPrefPoints);
    if (points == null) {
      sharedPref.setInt(sharedPrefPoints, 100);
      points = sharedPref.getInt(sharedPrefPoints);
    }

    var words = sharedPref.getInt(sharedPrefWordsCount);
    if (words == null) {
      sharedPref.setInt(sharedPrefWordsCount, 0);
      words = sharedPref.getInt(sharedPrefWordsCount);
    }

    emit(MenuState(points!, words!));
  }
}

abstract class MenuEvent {}

class MenuEventCheck extends MenuEvent {}

class MenuEventAddPointsAndWord extends MenuEvent {
  final int points;
  final int words;

  MenuEventAddPointsAndWord(this.points, this.words);
}

class MenuEventGetAnswer extends MenuEvent {}

class MenuState {
  final int points;
  final int words;

  MenuState(this.points, this.words);
}
