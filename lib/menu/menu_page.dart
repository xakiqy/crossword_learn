import 'package:crossword_learn/vocabulary/vocabulary_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../util/screen_size_reducer.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SizedBox(
          width: screenWidth(context),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: Image.asset('assets/moon.png', width: 45, height: 45,),
                )
              ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('app-name'.tr(), style: const TextStyle(fontSize: 22)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.orange,
                      ),
                      child: Text('crossword'.tr(), style: const TextStyle(fontSize: 20)), onPressed: () {
                      Navigator.pushNamed(context, '/crosswordPage');
                    },
                  )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(child: Text('language'.tr(), style: const TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.orange,
                      ),
                      onPressed: () {
                      // context.read<CrosswordBloc>().add(CrosswordEventLoad());
                      Navigator.pushNamed(context, '/languagePage');
                    },),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(child: Text('vocabulary'.tr(), style: const TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.orange,
                      ),
                      onPressed: () {
                      context.read<VocabularyBloc>().add(VocabularyEventLoad());
                      Navigator.pushNamed(context, '/vocabularyPage');
                    },),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}

