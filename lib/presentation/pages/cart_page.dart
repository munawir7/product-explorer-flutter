
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/product.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Consumer2<CartProvider, ProductProvider>(
        builder: (
          context,
          cart,
          productProvider,
          child,
        ) {
          // ==================================================
          // EMPTY CART
          // ==================================================

          if (cart.cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add some products to your cart.',
                  ),
                ],
              ),
            );
          }

          // ==================================================
          // CART PRODUCTS
          // ==================================================

          // IMPORTANT:
          // Use allProducts instead of products.
          // products contains only currently visible/filtered
          // products.

          final cartProducts =
              productProvider.allProducts
                  .where(
                    (product) =>
                        cart.cartItems
                            .containsKey(product.id),
                  )
                  .toList();

          // ==================================================
          // CART
          // ==================================================

          return Column(
            children: [
              // ------------------------------------------------
              // CART ITEMS
              // ------------------------------------------------

              Expanded(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.all(16),
                  itemCount:
                      cartProducts.length,
                  separatorBuilder:
                      (_, __) =>
                          const SizedBox(height: 12),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final product =
                        cartProducts[index];

                    return _buildCartItem(
                      context,
                      cart,
                      product,
                    );
                  },
                ),
              ),

              // ------------------------------------------------
              // CART SUMMARY
              // ------------------------------------------------

              _buildCartSummary(
                context,
                cart,
                cartProducts,
              ),
            ],
          );
        },
      ),
    );
  }

  // ==========================================================
  // CART ITEM
  // ==========================================================

  Widget _buildCartItem(
    BuildContext context,
    CartProvider cart,
    Product product,
  ) {
    final quantity =
        cart.getQuantity(product.id);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // ------------------------------------------------
            // PRODUCT IMAGE
            // ------------------------------------------------

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(12),
              child: Image.network(
                product.image,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder:
                    (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons
                          .image_not_supported_outlined,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            // ------------------------------------------------
            // PRODUCT DETAILS
            // ------------------------------------------------

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '₹${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ------------------------------------------------
                  // QUANTITY CONTROLS
                  // ------------------------------------------------

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          cart.removeOne(
                            product.id,
                          );
                        },
                        icon: const Icon(
                          Icons
                              .remove_circle_outline,
                        ),
                        padding: EdgeInsets.zero,
                        constraints:
                            const BoxConstraints(),
                      ),

                      const SizedBox(width: 12),

                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 12),

                      IconButton(
                        onPressed: () {
                          cart.addToCart(
                            product,
                          );
                        },
                        icon: const Icon(
                          Icons
                              .add_circle_outline,
                        ),
                        padding: EdgeInsets.zero,
                        constraints:
                            const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ------------------------------------------------
            // DELETE
            // ------------------------------------------------

            IconButton(
              onPressed: () {
                cart.removeFromCart(
                  product.id,
                );
              },
              icon: const Icon(
                Icons.delete_outline,
              ),
              tooltip: 'Remove',
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // CART SUMMARY
  // ==========================================================

  Widget _buildCartSummary(
    BuildContext context,
    CartProvider cart,
    List<Product> products,
  ) {
    final total =
        cart.totalPrice(products);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black
                .withValues(alpha: 0.08),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // ------------------------------------------------
            // TOTAL ITEMS
            // ------------------------------------------------

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${cart.cartCount}',
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ------------------------------------------------
            // TOTAL PRICE
            // ------------------------------------------------

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ------------------------------------------------
            // CHECKOUT
            // ------------------------------------------------

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Not Updated',
                      ),
                    ),
                  );
                },
                style:
                    ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Procceed to checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

