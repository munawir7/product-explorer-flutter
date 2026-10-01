
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/presentation/pages/product_details.page.dart';

import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          final favorites = provider.favoriteProducts;

          // ------------------------------------------------
          // NO FAVORITES
          // ------------------------------------------------

          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 70,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the heart icon to save products.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // ------------------------------------------------
          // FAVORITES
          // ------------------------------------------------

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              int columns;

              if (width < 600) {
                columns = 1;
              } else if (width < 900) {
                columns = 2;
              } else if (width < 1200) {
                columns = 3;
              } else {
                columns = 4;
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favorites.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio:
                      columns == 1 ? 3.2 : 0.85,
                ),
                itemBuilder: (context, index) {
                  final product = favorites[index];

                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailsPage(
                            product: product,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

