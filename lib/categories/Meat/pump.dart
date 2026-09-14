import 'package:prototype/utils/shopping_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class P extends StatefulWidget {
  const P({super.key});

  @override
  State<P> createState() => _PState();
}

class _PState extends State<P> {
  final pump = FirebaseFirestore.instance.collection('pump');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
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
        stream: pump.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Icon(
                    Icons.restaurant_menu,
                    size: 120,
                    color: Colors.blueGrey,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Pumpkin',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 235, 226, 226),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        '\$ 18.09',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 157, 20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 19),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Pumpkin is a plump, nutritious orange vegetable, and a highly nutrient dense food. It is low in calories but rich in vitamins and minerals, all of which are also in its seeds, leaves, and juices.',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 5),
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
                                            snapshot.data!.docs[index]['image'],
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
