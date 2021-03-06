import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moomi/helper/testingDatabase.dart';
import 'package:moomi/providers/generalDataProvider.dart';
import 'package:moomi/providers/notesProvider.dart';
import 'package:provider/provider.dart';

import './screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[800]));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NotesProvider(),
        ),
        ChangeNotifierProvider.value(
          value: GeneralDataProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Color(0xffFCF8F8),
            primaryColor: Color(0xff621A75),
            accentColor: Color(0xffD0FF85),
            fontFamily: 'Rubic'),
        home: TestingHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
