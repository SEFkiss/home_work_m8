import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lessons/fetch_file.dart';

class Task2 extends StatefulWidget {
  const Task2({Key? key}) : super(key: key);
  @override
  State<Task2> createState() => _Task2State();
}

class _Task2State extends State<Task2> {
  // Строка для имени запрашиваемого файла
  String request = '';
  // Функция для обновления состояния строки имени файла
  void search(String inputText) {
    setState(() {
      request = inputText + '.txt';
    });
  }

  // Вохвращает фьюча билдер
  Widget getContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (request != '')
            FutureBuilder(
              future: fetchFileFromAssets(request),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    return Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            // Показать имя файла который был найден
                            if (snapshot.data.toString() != 'Err' &&
                                snapshot.data.toString() != '')
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    RichText(
                                        text: const TextSpan(text: 'Файл ')),
                                    RichText(
                                        text: TextSpan(
                                            text: request,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600))),
                                    RichText(
                                        text: const TextSpan(
                                            text: ' был успешно найден!')),
                                  ],
                                ),
                              ),
                            // Показать ошибку если файл не был найден
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  if (snapshot.data.toString() == 'Err' &&
                                      request != '.txt')
                                    Row(
                                      children: [
                                        RichText(
                                            text: const TextSpan(
                                                text: 'Файл c именем ')),
                                        RichText(
                                            text: TextSpan(
                                                text: request,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        RichText(
                                            text: const TextSpan(
                                                text: ' не был найден!')),
                                      ],
                                    ),
                                  // Рендер текста файла если все ок
                                  if (snapshot.data.toString() != 'Err' &&
                                      request != '')
                                    Text(snapshot.data.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String inputText = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 2'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 350,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        onChanged: (string) {
                          // Присваиваем строку переменной чтобы в любой момент можно было к ней обратиться
                          inputText = string;
                          // Авто очистка страницы если мы стрели все символы
                          if (string == '') {
                            search('');
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Введите имя файла...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Запускаем поиск
                        search(inputText);
                      },
                      child: Container(
                        child: const Text(
                          'Найти',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(9.5),
                            topRight: Radius.circular(9.5),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              getContent(),
            ],
          ),
        ),
      ),
    );
  }
}
