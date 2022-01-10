import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lista_app/my.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}



