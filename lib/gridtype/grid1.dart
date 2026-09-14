// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

class FruitGridDemo extends StatefulWidget {
  const FruitGridDemo({super.key});

  @override
  State<FruitGridDemo> createState() => _FruitGridDemoState();
}

class _FruitGridDemoState extends State<FruitGridDemo> {
  List images = [
    'https://media.istockphoto.com/id/1400057530/photo/bananas-isolated.jpg?s=1024x1024&w=is&k=20&c=-ruVq5DUbWNJxdLGKv445QzB1cc9AvqxKH3JZ2yrpRc=',
    'https://media.istockphoto.com/id/175428035/photo/white-and-black-grapes.jpg?s=1024x1024&w=is&k=20&c=FSo5Wm1yXi-LSsbL5pIV_Ck6mkmrkOCqREyi62Uh8zA=',
    'https://media.istockphoto.com/id/1400602031/photo/single-orange-fruit-slices-over-on-white-background-top-view.jpg?s=1024x1024&w=is&k=20&c=Gen4kXbYNHg9we8GOrPUx7biJ3mzPCLr9iFVVAz1dnA=',
    'https://media.istockphoto.com/id/185262648/photo/red-apple-with-leaf-isolated-on-white-background.jpg?s=1024x1024&w=is&k=20&c=Cls30uVAjNB0B_xKbBC2Yu5aM4AB5fGmW7rqLphx3b0=',
    'https://media.istockphoto.com/id/1393599686/photo/peach-fruit-one-cut-in-half-with-green-leaf.jpg?s=1024x1024&w=is&k=20&c=4ShKZaQ3LYmkEVyNHplBQn0pNxe3YQTRszFDumxWpT0=',
    'https://media.istockphoto.com/id/1318935291/photo/mango-fruit.webp?b=1&s=170667a&w=0&k=20&c=8fZf33svFZzjF-ekZUaCRyocTKd5PaqMssyhKpf0iYY=',
  ];
  List name = ['Banana', 'Grapes', 'Orange', 'Apple', 'Peach'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // number of items in each row
            mainAxisSpacing: 4.0, // spacing between rows
            crossAxisSpacing: 2.0, // spacing between columns
          ),
          padding: const EdgeInsets.all(5.0),
          itemCount: name.length,
          itemBuilder: (context, index) {
            return Container(
              color: const Color.fromARGB(255, 0, 134, 244),
              child: Center(
                child: Text(
                  name[index],
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
