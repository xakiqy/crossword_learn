import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../menu/menu_bloc.dart';

class WordsAndPoints extends StatelessWidget {
  const WordsAndPoints({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
      return Row(children: [
        Center(
            child: Container(
                width: 55,
                height: 39,
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      width: 55,
                      height: 32,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: Colors.black),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0, top: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2.0, top: 2),
                                                child: Text(
                                                    state.words.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3!
                                                        .copyWith(
                                                          fontSize: 13.5,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ))),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                color: Colors.black),
                                          ),
                                        ],
                                      ))))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Colors.green),
                      width: 40,
                      height: 13,
                      child: Center(
                        child: Text(
                          'words'.tr(),
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 11.5,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ]))),
        Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom:  8.0),
            child: Center(
                child: Container(
                    width: 65,
                    height: 39,
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          width: 65,
                          height: 32,
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      color: Colors.black),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6.0, top: 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0, top: 2),
                                                    child: Text(
                                                        state.points.toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline3!
                                                            .copyWith(
                                                                fontSize: 13.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors.green))),
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(6)),
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ))))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.green),
                          width: 40,
                          height: 13,
                          child: Center(
                            child: Text(
                              'points'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontSize: 11.5,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ]))))
      ]);
    });
  }
}
