
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget/cattle_recognizer.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MaterialApp(
      title: 'Cattle Classifier',
      theme: ThemeData.light(),
      home: const CattleRecognizer(),
      debugShowCheckedModeBanner: false,
    );
  }
}
