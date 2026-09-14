import 'package:prototype/utils/shopping_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prototype/Fruits/fruit.dart';
import 'package:prototype/auth/Deasert/deseart.dart';
import 'package:prototype/meat.dart';
import 'package:prototype/search/search.dart';
import 'package:flutter/material.dart';

class GroceryHome extends StatefulWidget {
  const GroceryHome({super.key, this.database});
  final FirebaseFirestore? database;

  @override
  State<GroceryHome> createState() => _GroceryHomeState();
}

class _GroceryHomeState extends State<GroceryHome> {
  late final design = (widget.database ?? FirebaseFirestore.instance)
      .collection('design');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: StreamBuilder(
        stream: design.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: SafeArea(
                    child: Text(
                      'Grocery',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 243, 239, 239),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductSearchScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(width: 20),
                                Text(
                                  'SEARCH',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                                color: Color.fromARGB(255, 231, 146, 127),
                              ),
                              child: InkWell(
                                child: const Icon(
                                  Icons.restaurant_menu,
                                  color: Colors.black54,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FruitCategories(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Fruits",
                            style: TextStyle(
                              color: Color.fromARGB(255, 231, 146, 127),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
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
                                color: Color.fromARGB(255, 231, 146, 127),
                              ),
                              child: InkWell(
                                child: const Icon(
                                  Icons.restaurant_menu,
                                  color: Colors.black54,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DessertCategories(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Dessert",
                            style: TextStyle(
                              color: Color.fromARGB(255, 231, 146, 127),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
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
                                color: Color.fromARGB(255, 231, 146, 127),
                              ),
                              child: InkWell(
                                child: const Icon(
                                  Icons.restaurant_menu,
                                  color: Colors.black54,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MeatCategories(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Meat",
                            style: TextStyle(
                              color: Color.fromARGB(255, 231, 146, 127),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Popular Deals',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                snapshot.hasError
                    ? const Text(
                        'Unable to load products. Check Firebase setup.',
                        style: TextStyle(color: Colors.blueGrey),
                      )
                    : snapshot.hasData && snapshot.data!.docs.isEmpty
                    ? const Text(
                        'No products available.',
                        style: TextStyle(color: Colors.blueGrey),
                      )
                    : snapshot.hasData
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(snapshot.data!.docs.length, (
                            index,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: InkWell(
                                onLongPress: () async {
                                  await addProduct(
                                    context,
                                    snapshot.data!.docs[index],
                                    'fav',
                                  );
                                },
                                child: Container(
                                  width: 190,
                                  height: 190,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.blueGrey,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                                    Icons.broken_image,
                                                  ),
                                          image: NetworkImage(
                                            productField(
                                              snapshot.data!.docs[index],
                                              'image',
                                            ),
                                          ),
                                          width: 90,
                                          height: 100,
                                        ),
                                        Text(
                                          productField(
                                            snapshot.data!.docs[index],
                                            'name',
                                          ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 29,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '\$${productField(snapshot.data!.docs[index], 'price')}',
                                                  style: const TextStyle(
                                                    fontSize: 23,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  productField(
                                                    snapshot.data!.docs[index],
                                                    'unit',
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    color: Colors.green[700],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                await addProduct(
                                                  context,
                                                  snapshot.data!.docs[index],
                                                  'cart',
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.add_shopping_cart,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}
