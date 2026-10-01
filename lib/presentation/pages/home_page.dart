
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/presentation/pages/favorite_page.dart';
import 'package:task/presentation/pages/product_details.page.dart';

import '../../domain/entities/product.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import 'cart_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController =
      ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<ProductProvider>().loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          // ==================================================
          // FAVORITES
          // ==================================================

          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              final favoriteCount =
                  provider.favoriteProducts.length;

              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const FavoritesPage(),
                    ),
                  );
                },
                tooltip: 'Favorites',
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                    ),

                    if (favoriteCount > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: _buildBadge(
                          favoriteCount,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),

          // ==================================================
          // CART
          // ==================================================

          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const CartPage(),
                    ),
                  );
                },
                tooltip: 'Cart',
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                    ),

                    if (cart.cartCount > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: _buildBadge(
                          cart.cartCount,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(width: 8),
        ],
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // =================================================
              // SEARCH
              // =================================================

              SliverToBoxAdapter(
                child: _buildSearchBar(provider),
              ),

              // =================================================
              // CATEGORIES
              // =================================================

              SliverToBoxAdapter(
                child: _buildCategories(provider),
              ),

              // =================================================
              // FEATURED
              // =================================================

              SliverToBoxAdapter(
                child: _buildFeaturedProducts(
                  provider,
                ),
              ),

              // =================================================
              // ALL PRODUCTS TITLE
              // =================================================

              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    16,
                    20,
                    16,
                    12,
                  ),
                  child: Text(
                    'All Products',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
                  ),
                ),
              ),

              // =================================================
              // PRODUCTS
              // =================================================

              if (provider.products.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'No products found',
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  sliver: SliverList(
                    delegate:
                        SliverChildBuilderDelegate(
                      (context, index) {
                        final product =
                            provider.products[index];

                        return _buildProductCard(
                          context,
                          product,
                          provider,
                        );
                      },
                      childCount:
                          provider.products.length,
                    ),
                  ),
                ),

              // =================================================
              // LOADING MORE
              // =================================================

              if (provider.isLoadingMore)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child:
                          CircularProgressIndicator(),
                    ),
                  ),
                ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
            ],
          );
        },
      ),
    );
  }

  // ==========================================================
  // BADGE
  // ==========================================================

  Widget _buildBadge(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 2,
      ),
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      constraints: const BoxConstraints(
        minWidth: 17,
        minHeight: 17,
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================================
  // SEARCH BAR
  // ==========================================================

  Widget _buildSearchBar(
    ProductProvider provider,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        8,
      ),
      child: TextField(
        onChanged: provider.searchProducts,
        decoration: InputDecoration(
          hintText: 'Search products',
          prefixIcon:
              const Icon(Icons.search),
          filled: true,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // CATEGORIES
  // ==========================================================

  Widget _buildCategories(
    ProductProvider provider,
  ) {
    final categories = [
      'All',
      'Electronics',
      'Fashion',
      'Shoes',
      'Accessories',
    ];

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            8,
          ),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          height: 45,
          child: ListView.separated(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            scrollDirection:
                Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (
              _,
              __,
            ) =>
                const SizedBox(width: 8),
            itemBuilder: (
              context,
              index,
            ) {
              final category =
                  categories[index];

              final isSelected =
                  provider.selectedCategory ==
                      category;

              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (_) {
                  provider.selectCategory(
                    category,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // FEATURED PRODUCTS
  // ==========================================================

  Widget _buildFeaturedProducts(
    ProductProvider provider,
  ) {
    final featuredProducts =
        provider.products
            .take(4)
            .toList();

    if (featuredProducts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            20,
            16,
            12,
          ),
          child: Text(
            'Featured',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          height: 205,
          child: ListView.builder(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            scrollDirection:
                Axis.horizontal,
            itemCount:
                featuredProducts.length,
            itemBuilder: (
              context,
              index,
            ) {
              final product =
                  featuredProducts[index];

              return GestureDetector(
                onTap: () {
                  _openProductDetails(
                    context,
                    product,
                  );
                },
                child: Container(
                  width: 160,
                  margin:
                      const EdgeInsets.only(
                    right: 12,
                  ),
                  child: Card(
                    clipBehavior:
                        Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Expanded(
                          child: Image.network(
                            product.image,
                            width:
                                double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return const Center(
                                child: Icon(
                                  Icons
                                      .image_not_supported,
                                ),
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets
                                  .all(8),
                          child: Text(
                            product.name,
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets
                                  .fromLTRB(
                            8,
                            0,
                            8,
                            8,
                          ),
                          child: Text(
                            '₹${product.price.toStringAsFixed(0)}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // PRODUCT CARD
  // ==========================================================

  Widget _buildProductCard(
    BuildContext context,
    Product product,
    ProductProvider provider,
  ) {
    final isFavorite =
        provider.isFavorite(product.id);

    return Card(
      margin:
          const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(12),
        onTap: () {
          _openProductDetails(
            context,
            product,
          );
        },
        child: Padding(
          padding:
              const EdgeInsets.all(10),
          child: Row(
            children: [
              // IMAGE
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),
                child: Image.network(
                  product.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      width: 70,
                      height: 70,
                      color:
                          Colors.grey.shade200,
                      child: const Icon(
                        Icons
                            .image_not_supported,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              // PRODUCT DETAILS
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
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      '₹${product.price.toStringAsFixed(0)} • ⭐ ${product.rating}',
                      style: TextStyle(
                        color: Colors
                            .grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              // FAVORITE
              IconButton(
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
                    ? 'Remove Favorite'
                    : 'Add Favorite',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // OPEN PRODUCT DETAILS
  // ==========================================================

  void _openProductDetails(
    BuildContext context,
    Product product,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ProductDetailsPage(
          product: product,
        ),
      ),
    );
  }
}

