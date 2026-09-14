import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String productField(DocumentSnapshot document, String field) {
  final data = document.data();
  if (data is! Map) return field == 'name' ? 'Unnamed item' : '';
  final value = data[field];
  if (value is String || value is num) return value.toString();
  return field == 'name' ? 'Unnamed item' : '';
}

Map<String, String> productData(DocumentSnapshot document) => {
  for (final key in ['name', 'image', 'price', 'unit'])
    key: productField(document, key),
};

String productId(DocumentSnapshot source) =>
    base64Url.encode(utf8.encode(source.reference.path));

Future<void> saveProduct(
  FirebaseFirestore database,
  String uid,
  String list,
  DocumentSnapshot source,
) async {
  await database
      .collection('user')
      .doc(uid)
      .collection(list)
      .doc(productId(source))
      .set(productData(source));
}

Future<void> moveFavorite(
  FirebaseFirestore database,
  String uid,
  DocumentSnapshot source,
) async {
  final target = database
      .collection('user')
      .doc(uid)
      .collection('cart')
      .doc(source.id);
  final batch = database.batch();
  batch.set(target, productData(source));
  batch.delete(source.reference);
  await batch.commit();
}

Future<void> addProduct(
  BuildContext context,
  DocumentSnapshot source,
  String list,
) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Sign in to save items.')));
    return;
  }
  try {
    await saveProduct(FirebaseFirestore.instance, user.uid, list, source);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          list == 'cart' ? 'Item added to cart' : 'Item added to favorites',
        ),
      ),
    );
  } on FirebaseException {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not save item. Please try again.')),
    );
  }
}
