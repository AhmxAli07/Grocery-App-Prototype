import 'package:flutter/material.dart';

class EmptyFavoritesMock extends StatefulWidget {
  const EmptyFavoritesMock({super.key});

  @override
  State<EmptyFavoritesMock> createState() => _EmptyFavoritesMockState();
}

class _EmptyFavoritesMockState extends State<EmptyFavoritesMock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                height: 350,
                decoration: const BoxDecoration(),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your heart is empty',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 33,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                ' Start fall in love with some good foods.',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(219, 255, 255, 255),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: SingleChildScrollView(
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SizedBox(width: 120),
                        Text(
                          'Start  shopping ',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
