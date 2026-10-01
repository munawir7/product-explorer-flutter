
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/product.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
        ),

        // =====================================================
        // FAVORITE ICON
        // =====================================================

        actions: [
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              final isFavorite =
                  provider.isFavorite(product.id);

              return IconButton(
                onPressed: () {
                  provider.toggleFavorite(
                    product.id,
                  );
                },
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: isFavorite
                      ? Colors.red
                      : null,
                ),
                tooltip: isFavorite
                    ? 'Remove from Favorites'
                    : 'Add to Favorites',
              );
            },
          ),
        ],
      ),

      // =======================================================
      // BODY
      // =======================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // =================================================
            // PRODUCT IMAGE
            // =================================================

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(20),
              child: Image.network(
                product.image,
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,
                errorBuilder:
                    (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    height: 320,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons
                          .image_not_supported_outlined,
                      size: 60,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // PRODUCT NAME
            // =================================================

            Text(
              product.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // =================================================
            // CATEGORY
            // =================================================

            Text(
              product.category,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 16),

            // =================================================
            // PRICE + RATING
            // =================================================

            Row(
              children: [
                Text(
                  '₹${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 22,
                ),

                const SizedBox(width: 5),

                Text(
                  product.rating.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =================================================
            // DESCRIPTION
            // =================================================

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // ADD TO CART
            // =================================================

            Consumer<CartProvider>(
              builder: (context, cart, child) {
                final quantity =
                    cart.getQuantity(product.id);

                return Column(
                  children: [
                    // Quantity controls
                    if (quantity > 0)
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              cart.removeOne(
                                product.id,
                              );
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                            ),
                          ),

                          Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              cart.addToCart(
                                product,
                              );
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          cart.addToCart(
                            product,
                          );

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Product added to cart',
                              ),
                              duration:
                                  Duration(
                                seconds: 1,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                        ),
                        label: Text(
                          quantity > 0
                              ? 'Add Another'
                              : 'Add to Cart',
                        ),
                        style:
                            ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 16),

            // =================================================
            // FAVORITE BUTTON
            // =================================================

            Consumer<ProductProvider>(
              builder: (context, provider, child) {
                final isFavorite =
                    provider.isFavorite(
                  product.id,
                );

                return SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      provider.toggleFavorite(
                        product.id,
                      );
                    },
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    label: Text(
                      isFavorite
                          ? 'Added to Favorites'
                          : 'Add to Favorites',
                    ),
                    style:
                        OutlinedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

