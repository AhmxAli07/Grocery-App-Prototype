import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/shopping_actions.dart';

/// Shared presentation for the original cart and favorite lists.
class SavedProducts extends StatelessWidget {
  const SavedProducts({super.key, required this.favorites});
  final bool favorites;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final database = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        title: Text(
          favorites ? 'Favourite' : 'CART',
          style: const TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: user == null
          ? const Center(child: Text('Sign in to view saved items.'))
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: database
                  .collection('user')
                  .doc(user.uid)
                  .collection(favorites ? 'fav' : 'cart')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Unable to load saved items.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      favorites ? 'No favorites yet.' : 'Your cart is empty.',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];
                    return Dismissible(
                      key: ValueKey(document.id),
                      background: Container(
                        color: Colors.lightBlue,
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(Icons.delete),
                        ),
                      ),
                      // Keep the row until the backend acknowledges deletion.
                      confirmDismiss: (_) async {
                        try {
                          await document.reference.delete();
                          return true;
                        } on FirebaseException {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not remove item.'),
                              ),
                            );
                          }
                          return false;
                        }
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 66, 62, 62),
                        child: ListTile(
                          leading: Image.network(
                            productField(document, 'image'),
                            width: 48,
                            height: 48,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                ),
                          ),
                          title: Text(
                            productField(document, 'name'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          subtitle: Text(
                            '\$${productField(document, 'price')} ${productField(document, 'unit')}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: favorites
                              ? IconButton(
                                  tooltip: 'Move to cart',
                                  icon: const Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.lightBlue,
                                  ),
                                  onPressed: () async {
                                    try {
                                      await moveFavorite(
                                        database,
                                        user.uid,
                                        document,
                                      );
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Item moved to cart'),
                                          ),
                                        );
                                      }
                                    } on FirebaseException {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Could not move item. Your favorite was kept.',
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
