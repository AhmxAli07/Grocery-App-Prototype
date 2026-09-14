import 'package:prototype/utils/shopping_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IceCreamScreen extends StatefulWidget {
  const IceCreamScreen({super.key});

  @override
  State<IceCreamScreen> createState() => _IceCreamScreenState();
}

class _IceCreamScreenState extends State<IceCreamScreen> {
  final ice = FirebaseFirestore.instance.collection('Ice Cream');

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
        stream: ice.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
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
                      padding: EdgeInsets.all(13.0),
                      child: Text(
                        'Ice Cream',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 235, 226, 226),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(13.0),
                      child: Text(
                        '\$ 7.09',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 245, 196, 245),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Ice cream is a frozen dessert typically made from milk or cream that has been flavoured with a sweetener, either sugar or an alternative, and a spice, such as cocoa or vanilla, or with fruit, such as strawberries or peaches. Food colouring is sometimes added in addition to stabilizers. ',
                    style: TextStyle(
                      fontSize: 25,
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
