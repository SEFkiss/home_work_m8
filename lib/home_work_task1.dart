import 'package:flutter/material.dart';
import 'package:lessons/fetch_file.dart';

class Task1 extends StatefulWidget {
  const Task1({Key? key}) : super(key: key);
  @override
  State<Task1> createState() => _Task1State();
}

class _Task1State extends State<Task1> {
  late Future<String> futureString;

  @override
  void initState() {
    // Не существует
    futureString = fetchFileFromAssets1('data5.txt');
    // Существует
    // futureString = fetchFileFromAssets1('data.txt');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 1'),
      ),
      body: FutureBuilder(
        // В билдер кидаем ранее полученную строку
        future: futureString,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return const CircularProgressIndicator();
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text(snapshot.data.toString())),
                  ],
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
