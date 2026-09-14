// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // final _auth = FirebaseAuth.instance;
  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Center(
              child: SafeArea(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'fruits',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(width: 60),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 189, 158, 243),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/grape');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Grapes",
                      style: TextStyle(
                        color: Color.fromARGB(255, 189, 158, 243),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 216, 194, 161),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/banana');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Banana",
                      style: TextStyle(
                        color: Color.fromARGB(255, 216, 194, 161),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 94, 56, 47),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/apple');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Apple",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 6, 6),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 252, 252, 252),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/avocado');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Avocado",
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 244, 0),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Dessert',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(width: 60),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 247, 197, 233),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/ic');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Ice Cream",
                      style: TextStyle(
                        color: Color.fromARGB(255, 247, 197, 233),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 172, 239, 96),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/j');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "juice",
                      style: TextStyle(
                        color: Color.fromARGB(255, 172, 239, 96),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 236, 112, 84),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/ca');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "cake",
                      style: TextStyle(
                        color: Color.fromARGB(255, 222, 171, 160),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 32, 224, 234),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/e');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Egg & Milk",
                      style: TextStyle(
                        color: Color.fromARGB(255, 32, 224, 234),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Meat',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(width: 60),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 238, 161, 98),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/Meat');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Cow Meat",
                      style: TextStyle(
                        color: Color.fromARGB(255, 238, 161, 98),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 247, 244, 243),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/Fish');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Fish",
                      style: TextStyle(
                        color: Color.fromARGB(255, 168, 96, 167),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 244, 234, 92),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/Sea');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Sea Hawk",
                      style: TextStyle(
                        color: Color.fromARGB(255, 244, 234, 92),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 228, 177, 100),
                        ),
                        child: InkWell(
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/Pumpkins');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Pumpkin",
                      style: TextStyle(
                        color: Color.fromARGB(255, 234, 146, 23),
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
