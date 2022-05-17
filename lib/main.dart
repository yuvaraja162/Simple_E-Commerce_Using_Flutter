import 'package:flutter/material.dart';
import 'homepage.dart';
import 'productview.dart';

// this application created on 16/05/2022
// Flutter Assignment

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HomePage(),
      routes: {
        '/': (context) => const HomePage(),
        '/addproduct': (context) => productview()
      },
    );
  }
}
