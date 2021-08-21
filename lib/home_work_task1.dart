import 'package:flutter/material.dart';
import 'package:lessons/fetch_file.dart';

class Task1 extends StatefulWidget {
  const Task1({Key? key}) : super(key: key);
  @override
  State<Task1> createState() => _Task1State();
}

class _Task1State extends State<Task1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 1'),
      ),
      body: FutureBuilder(
        // Не существующий файл
        future: fetchFileFromAssets1('data5.txt'),
        // Существующий файл
        // future: fetchFileFromAssets1('data.txt'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return CircularProgressIndicator();
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return Text(snapshot.data.toString());
            default:
              return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
