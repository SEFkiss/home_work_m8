import 'package:flutter/material.dart';
import 'package:lessons/home_work_task1.dart';
import 'package:lessons/home_work_task2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // Задание 1
      home: const Task1(),

      // Задание 2
      // home: const Task2(),
    );
  }
}
