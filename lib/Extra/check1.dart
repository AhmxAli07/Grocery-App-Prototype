import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductEntryDemo extends StatefulWidget {
  const ProductEntryDemo({super.key});

  @override
  State<ProductEntryDemo> createState() => _ProductEntryDemoState();
}

class _ProductEntryDemoState extends State<ProductEntryDemo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final design = FirebaseFirestore.instance.collection('products');
  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(controller: _nameController),
          TextFormField(controller: _imageController),
          ElevatedButton(
            onPressed: () {
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              design.doc(id).set({
                'name': _nameController.text.toString(),
                'id': id,
              });
              // design
              //     .doc(id)
              //     .set({'image': _imageController.text.toString(), 'id': id});
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
