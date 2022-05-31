import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:just_audio/just_audio.dart';

import '../core/constant.dart';
import 'language_bloc.dart';

class WelcomeLanguagePage extends StatefulWidget {
  const WelcomeLanguagePage({Key? key}) : super(key: key);

  @override
  State<WelcomeLanguagePage> createState() => _WelcomeLanguagePageState();
}

class _WelcomeLanguagePageState extends State<WelcomeLanguagePage> {
  String? currentLang;
  String? learnLang;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: kToolbarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('choose-current-lang'.tr()),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: currentLang == tableWordsEn
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset(
                          'assets/great-britain.png',
                        )),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        currentLang = tableWordsEn;
                      });
                      context.setLocale(Locale('en'));
                    },
                  ),
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: currentLang == tableWordsUa
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset('assets/ukraine.png')),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        currentLang = tableWordsUa;
                      });
                      context.setLocale(Locale('uk'));
                    },
                  ),
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: currentLang == tableWordsHi
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset('assets/india.png')),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        currentLang = tableWordsHi;
                      });
                      context.setLocale(Locale('hi'));
                    },
                  ),
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: currentLang == tableWordsAr
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset('assets/arabic.png')),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        currentLang = tableWordsAr;
                      });
                      context.setLocale(Locale('ar'));
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: currentLang == tableWordsEs
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset('assets/spain.png')),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        currentLang = tableWordsEs;
                      });
                      context.setLocale(Locale('es'));
                    },
                  ),
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: currentLang == tableWordsPt
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset('assets/portuguese.png')),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        currentLang = tableWordsPt;
                      });
                      context.setLocale(Locale('pt'));
                    },
                  ),
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: currentLang == tableWordsRu
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset('assets/russia.png')),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        currentLang = tableWordsRu;
                      });
                      context.setLocale(Locale('ru'));
                    },
                  )
                ],
              ),
            ),
            Text('choose-learn-lang'.tr()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 45.0,
                  icon: Container(
                      decoration: learnLang == tableWordsEn
                          ? BoxDecoration(
                          border: Border.all(
                              color: Colors.blueAccent, width: 2),
                          borderRadius: BorderRadius.circular(5))
                          : const BoxDecoration(),
                      child: Image.asset('assets/great-britain.png')),
                  onPressed: () async {
                    await audioPlayer.setAsset('assets/switch.mp3');
                    audioPlayer.play();
                    setState(() {
                      learnLang = tableWordsEn;
                    });
                  },
                ),
                IconButton(
                  iconSize: 45.0,
                  icon: Container(
                      decoration: learnLang == tableWordsUa
                          ? BoxDecoration(
                          border: Border.all(
                              color: Colors.blueAccent, width: 2),
                          borderRadius: BorderRadius.circular(5))
                          : const BoxDecoration(),
                      child: Image.asset('assets/ukraine.png')),
                  onPressed: () async {
                    await audioPlayer.setAsset('assets/switch.mp3');
                    audioPlayer.play();
                    setState(() {
                      learnLang = tableWordsUa;
                    });
                  },
                ),
                IconButton(
                  iconSize: 45.0,
                  icon: Container(
                      decoration: learnLang == tableWordsHi
                          ? BoxDecoration(
                          border: Border.all(
                              color: Colors.blueAccent, width: 2),
                          borderRadius: BorderRadius.circular(5))
                          : const BoxDecoration(),
                      child: Image.asset('assets/india.png')),
                  onPressed: () async {
                    await audioPlayer.setAsset('assets/switch.mp3');
                    audioPlayer.play();
                    setState(() {
                      learnLang = tableWordsHi;
                    });
                  },
                ),
                IconButton(
                  iconSize: 45.0,
                  icon: Container(
                      decoration: learnLang == tableWordsAr
                          ? BoxDecoration(
                          border: Border.all(
                              color: Colors.blueAccent, width: 2),
                          borderRadius: BorderRadius.circular(5))
                          : const BoxDecoration(),
                      child: Image.asset('assets/arabic.png')),
                  onPressed: () async {
                    await audioPlayer.setAsset('assets/switch.mp3');
                    audioPlayer.play();
                    setState(() {
                      learnLang = tableWordsAr;
                    });
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: learnLang == tableWordsEs
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset('assets/spain.png')),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        learnLang = tableWordsEs;
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: learnLang == tableWordsPt
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset('assets/portuguese.png')),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        learnLang = tableWordsPt;
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 45.0,
                    icon: Container(
                        decoration: learnLang == tableWordsRu
                            ? BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(5))
                            : const BoxDecoration(),
                        child: Image.asset('assets/russia.png')),
                    onPressed: () async {
                      await audioPlayer.setAsset('assets/switch.mp3');
                      audioPlayer.play();
                      setState(() {
                        learnLang = tableWordsRu;
                      });
                    },
                  )
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  elevation: 6,
                  primary: buttonAvailable(currentLang, learnLang)
                      ? Colors.white
                      : Colors.grey.shade400,
                  onPrimary: Colors.blueAccent,
                ),
                onPressed: () {
                  if (buttonAvailable(currentLang, learnLang)) {
                    context
                        .read<LanguageBloc>()
                        .add(LanguageEventChange(currentLang!, learnLang!));
                  }
                },
                child: Text('language-button-text'.tr())),
          ],
        ),
      ),
    );
  }

  bool buttonAvailable(String? currentLang, String? learnLang) {
    if (currentLang != null && learnLang != null) {
      return true;
    }
    return false;
  }
}
