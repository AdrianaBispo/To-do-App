import 'package:flutter/material.dart';
import 'package:lista_app/src/pages/home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      home: AddData(),
    );
  }
}