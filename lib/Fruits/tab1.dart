import 'package:prototype/utils/shopping_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TAB1 extends StatefulWidget {
  const TAB1({super.key, this.database});
  final FirebaseFirestore? database;

  @override
  State<TAB1> createState() => _TAB1State();
}

class _TAB1State extends State<TAB1> {
  late final fruit = (widget.database ?? FirebaseFirestore.instance).collection(
    'fruits',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: StreamBuilder(
        stream: fruit.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Unable to load data. Check your connection and Firebase setup.',
                style: TextStyle(color: Colors.blueGrey),
              ),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No items available.',
                style: TextStyle(color: Colors.blueGrey),
              ),
            );
          }
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.sizeOf(context).width < 360
                        ? 1
                        : 2,
                    mainAxisExtent: 240,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onLongPress: () async {
                          await addProduct(
                            context,
                            snapshot.data!.docs[index],
                            'fav',
                          );
                        },
                        child: Container(
                          width: 200,
                          height: 205,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                  image: NetworkImage(
                                    productField(
                                      snapshot.data!.docs[index],
                                      'image',
                                    ),
                                  ),
                                  width: 90,
                                  height: 75,
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
                                Wrap(
                                  alignment: WrapAlignment.center,
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
                                      icon: const Icon(Icons.add_shopping_cart),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
