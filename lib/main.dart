import 'package:flutter/material.dart';
import 'package:resepp/dbhelper.dart';
import 'package:resepp/home.dart';
import 'package:resepp/akunsaya.dart';
import 'package:resepp/api.dart';
import 'package:resepp/resepsaya.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().initDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/akunsaya': (context) => AkunSayaPage(),
        '/resepsaya': (context) => ResepSayaPage(),
      },
    );
  }
}
