import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dynamic temp = snapshot.data;
                  List names = List.generate(
                      temp.length, (index) => temp[index]['name']);

                  List streets = List.generate(
                      temp.length, (index) => temp[index]['address']['street']);
                  return ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: names.length,
                      itemBuilder: (context, index) => ListTile(
                            title: Text('NAME: '+names[index]),
                            subtitle: Text('STREET : '+streets[index]),
                          ));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}

getData() async {
  Dio restfullExample = Dio();
  Response response =
      await restfullExample.get('https://jsonplaceholder.typicode.com/users');
  print(response.data[1]['email']);
  return response.data;
}
