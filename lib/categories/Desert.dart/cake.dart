import 'package:prototype/utils/shopping_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CakeScreen extends StatefulWidget {
  const CakeScreen({super.key});

  @override
  State<CakeScreen> createState() => _CakeScreenState();
}

class _CakeScreenState extends State<CakeScreen> {
  final ca = FirebaseFirestore.instance.collection('Cake');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
          // style: ButtonStyle(),
        ),
        elevation: 10,
        shadowColor: Colors.white70,
      ),
      body: StreamBuilder(
        stream: ca.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: Row(
                    children: [
                      SizedBox(width: 90),
                      Icon(
                        Icons.restaurant_menu,
                        size: 120,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Cake',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 235, 226, 226),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        '\$ 2.09',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 12, 240, 240),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'A cake is a type of (usually) sweet dessert which is baked. Originally, it was a bread-like food, but no longer. Cakes are often made to celebrate special occasions like birthdays or weddings. There are many kinds of cakes.',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'You May Also Need',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 235, 226, 226),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                    : snapshot.hasError
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
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
