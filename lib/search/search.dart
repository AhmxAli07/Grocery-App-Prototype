import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/shopping_actions.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});
  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  Timer? _debounce;
  int _request = 0;
  bool _loading = false;
  String? _error;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _results = [];

  void searchfrom(String query) {
    _debounce?.cancel();
    final request = ++_request;
    setState(() {
      _loading = query.trim().isNotEmpty;
      _error = null;
      _results = [];
    });
    if (query.trim().isEmpty) return;
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final result = await FirebaseFirestore.instance
            .collection('Search')
            .where('name_array', arrayContains: query.trim())
            .get();
        if (!mounted || request != _request) return;
        setState(() {
          _results = result.docs;
          _loading = false;
        });
      } on FirebaseException {
        if (!mounted || request != _request) return;
        setState(() {
          _error =
              'Unable to search. Check your connection and Firebase setup.';
          _loading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color.fromARGB(255, 48, 47, 47),
    appBar: AppBar(title: const Text('Search')),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            onChanged: searchfrom,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : _results.isEmpty
              ? const Center(
                  child: Text(
                    'No results. Enter a product search term.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final document = _results[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          productField(document, 'image'),
                          width: 48,
                          height: 48,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        ),
                        title: Text(productField(document, 'name')),
                        subtitle: Text(
                          '\$${productField(document, 'price')} ${productField(document, 'unit')}',
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    ),
  );
}
