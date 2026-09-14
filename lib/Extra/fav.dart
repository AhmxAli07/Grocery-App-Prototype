import 'package:flutter/material.dart';
import '../widgets/saved_products.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) => const SavedProducts(favorites: true);
}
