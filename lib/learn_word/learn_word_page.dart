import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../util/screen_size_reducer.dart';

class LearnWordPage extends StatelessWidget {
  const LearnWordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight(context, dividedBy: 6),
            width: double.infinity,
          ),
          const Text('Word'),
          const Text('Word hint'),
          ElevatedButton(onPressed: (){}, child: Text('next'.tr()))
        ],
      ),
    );
  }
}