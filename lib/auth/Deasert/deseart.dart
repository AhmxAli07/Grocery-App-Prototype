import 'package:prototype/Fruits/tab1.dart';
import 'package:prototype/Fruits/tab2.dart';
import 'package:prototype/Fruits/tab3.dart';
import 'package:flutter/material.dart';

class DessertCategories extends StatefulWidget {
  const DessertCategories({super.key});

  @override
  State<DessertCategories> createState() => _DessertCategoriesState();
}

class _DessertCategoriesState extends State<DessertCategories>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 29, 162, 229),
          title: const Row(
            children: [
              SizedBox(width: 55),
              Text(
                'Categories',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          shape: null,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          bottom: TabBar(
            controller: _controller,
            tabs: const [
              Tab(text: 'Dessert'),
              Tab(text: 'Fruits'),
              Tab(text: 'Meat'),
            ],
            indicatorColor: const Color.fromARGB(255, 168, 214, 237),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: const [DessertProducts(), TAB1(), Tab3()],
        ),
      ),
    );
  }
}
