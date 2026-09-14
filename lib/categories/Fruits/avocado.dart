import 'package:prototype/utils/shopping_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvocadoScreen extends StatefulWidget {
  const AvocadoScreen({super.key});

  @override
  State<AvocadoScreen> createState() => _AvocadoScreenState();
}

class _AvocadoScreenState extends State<AvocadoScreen> {
  final avo = FirebaseFirestore.instance.collection('Avocado');

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
        shadowColor: Color.fromARGB(179, 143, 136, 136),
      ),
      body: StreamBuilder(
        stream: avo.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Avocado Bowl',
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
                        '\$ 11.09',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 209, 155, 135),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Avocado fruits have greenish or yellowish flesh with a buttery consistency and a rich nutty flavour. They are often eaten in salads, and in many parts of the world they are eaten as a dessert. Mashed avocado is the principal ingredient of guacamole, a characteristic saucelike condiment in Mexican cuisine.',
                    style: TextStyle(
                      fontSize: 24,
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
                const SizedBox(height: 10),
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
